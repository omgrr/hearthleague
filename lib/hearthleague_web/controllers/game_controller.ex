defmodule HearthleagueWeb.GameController do
  use HearthleagueWeb, :controller

  alias Hearthleague.Game
  alias Hearthleague.Match

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Repo.get!(Game, id) |> Repo.preload([:nerds, match: [:games]])
    changeset = Game.changeset(game, %{winning_nerd_id: game_params["winning_nerd_id"]})

    [ nerd_1 | [nerd_2] ] = game.nerds

    nerd_1_games = game.match.games |> Enum.filter(&(&1.winning_nerd_id == nerd_1.id)) |> Enum.count
    nerd_2_games = game.match.games |> Enum.filter(&(&1.winning_nerd_id == nerd_2.id)) |> Enum.count

    check_match_status(nerd_1_games, nerd_2_games, nerd_1.id, nerd_2.id, game.match)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
          |> put_flash(:info, "game updated successfully!")
          |> redirect(to: match_path(conn, :edit, game.match))
      :error ->
        conn
          |> put_flash(:info, "Game failed to update")
          |> redirect(to: match_path(conn, :edit, game.match))
    end
  end

  def check_match_status(nerd_1_games, _, id1, id2, match) when nerd_1_games >= 1 do
    changeset = Match.changeset(match, %{winning_nerd_id: id1, losing_nerd_id: id2})
    IO.inspect(changeset)
    Repo.update(changeset)
  end

  def check_match_status(_, nerd_2_games, id1, id2, match) when nerd_2_games >= 1 do
    changeset = Match.changeset(match, %{winning_nerd_id: id2, losing_nerd_id: id1})
    IO.inspect(changeset)
    Repo.update(changeset)
  end

  def check_match_status(_, _, _, _, _) do
    IO.puts "Nothing to update"
  end
end
