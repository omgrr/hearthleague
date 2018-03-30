defmodule HearthleagueWeb.MatchController do
  use HearthleagueWeb, :controller

	import Ecto.Query

  alias Hearthleague.Match
  alias Hearthleague.Game

  def edit(conn, %{"id" => id}) do
    match = Repo.get!(Match, id) |> Repo.preload([:nerds, games: from(g in Game, order_by: g.inserted_at, preload: [:nerds, :match])])
    games = Enum.map(match.games, &( [changeset: Game.changeset(&1, %{}), game: &1]))

    render(conn, "edit.html", match: match, games: games)
  end
end
