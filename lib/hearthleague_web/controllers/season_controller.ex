defmodule HearthleagueWeb.SeasonController do
  use HearthleagueWeb, :controller

	import Ecto.Query

  alias Hearthleague.Season
  alias Hearthleague.Match
  alias Hearthleague.Game

  def index(conn, _params) do
    seasons = Repo.all(Season, preload: [:matches])
    render conn, "index.html", seasons: seasons
  end

  def new(conn, _params) do
    changeset = Season.changeset(%Season{}, %{})
    render conn, "new.html", changeset: changeset
  end

	def create(conn, %{"season" => season_params}) do
		params = Map.put(season_params, "status", "Open")
    changeset = Season.changeset(%Season{}, params)

    case Repo.insert(changeset) do
      {:ok, _season} ->
        conn
        |> put_flash(:info, "Season created successfully.")
        |> redirect(to: season_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

	def show(conn, %{"id" => id}) do
		season = get_season(id)
		nerds_score_table = get_nerds_score_table(season.id)
    render(conn, "show.html", season: season, nerds_score_table: nerds_score_table)
	end

	def update(conn, %{"id" => id, "season" => %{"start_season" => "true"}}) do
    season = get_season(id)

    create_season_matches(season, Enum.reverse(season.nerds))

    create_season_matches(season, season.nerds)
      |> close_season

		conn
			|> put_flash(:info, "Season started!")
      |> redirect(to: season_path(conn, :show, season.id))
	end

	def update(conn, %{"id" => id}) do
		season = get_season(id)
		nerds = season.nerds ++ [HearthleagueWeb.SessionHelper.current_nerd(conn)]

		changeset = Season.changeset(season, %{nerds: nerds})
		case Repo.update(changeset) do
		{:ok, season} ->
			conn
				|> put_flash(:info, "Welcome to #{season.name}")
				|> render("show.html", season: season)
		{:error, _} ->
			conn
				|> put_flash(:info, "Errors")
				|> render("show.html", season: season)
		end
	end

	def get_season(id) do
    season = Repo.get!(Season, id) |> Repo.preload([:nerds, matches: from(m in Match, order_by: m.inserted_at, preload: [:nerds, :games])])
		season
	end

  def create_season_matches(season, []), do: season
  def create_season_matches(season, [next_nerd | rest_of_nerds]) do
    create_nerds_matches(season, next_nerd, rest_of_nerds)
    create_season_matches(season, rest_of_nerds)
  end

  def create_nerds_matches(season, _, []), do: season
  def create_nerds_matches(season, current_nerd, [next_nerd | rest_of_nerds]) do
    match_changeset = Match.changeset(%Match{}, %{season_id: season.id, nerds: [current_nerd, next_nerd]})
    case Repo.insert(match_changeset) do
      {:ok, match} ->
        create_games(match, [current_nerd, next_nerd], 3)
      :error -> nil
    end

    create_nerds_matches(season, current_nerd, rest_of_nerds)
  end

  def create_games(match, _, 0), do: match
  def create_games(match, nerds, n) when n > 0 do
    game_changeset = Game.changeset(%Game{}, %{match_id: match.id, nerds: nerds})
    Repo.insert(game_changeset)
    create_games(match, nerds, n - 1)
  end

  def close_season(season) do
    Season.changeset(season, %{status: "In progress"})
      |> Repo.update
  end

	def get_nerds_score_table(season_id) do
		Ecto.Adapters.SQL.query!(Repo, nerds_score_table_sql(), [season_id]).rows
  end

	defp nerds_score_table_sql do
		"""
with rows as
  (
    select
      nerds.name as nerds_name,
      nerds.id as nerds_id,
      matches.winning_nerd_id as matches_winning_nerd_id,
      games.winning_nerd_id as games_winning_nerd_id,
      matches.id as matches_id,
      games.id as games_id
    from seasons
    inner join nerd_seasons on seasons.id = nerd_seasons.season_id
    inner join nerds on nerd_seasons.nerd_id = nerds.id
    inner join matches on matches.season_id = seasons.id
    inner join games on matches.id = games.match_id
    where seasons.id = $1
  ),
matches_won as
  (
    select
      nerds_name,
      nerds_id,
      count(distinct matches_id) as number_matches_won
    from rows
    where matches_winning_nerd_id = nerds_id
    group by
      nerds_name,
      nerds_id
  ),
games_won as
  (
    select
      nerds_name,
      nerds_id,
      count(distinct games_id) as number_games_won
    from rows
    where games_winning_nerd_id = nerds_id
    group by
      nerds_name,
      nerds_id
  )
select
  matches_won.nerds_name,
  matches_won.nerds_id,
  number_matches_won,
  number_games_won
from matches_won
inner join games_won on matches_won.nerds_id = games_won.nerds_id
order by number_matches_won desc
"""
	end
end
