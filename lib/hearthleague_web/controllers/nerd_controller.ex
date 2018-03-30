defmodule HearthleagueWeb.NerdController do
  use HearthleagueWeb, :controller

  alias Hearthleague.Nerd

  def index(conn, _params) do
    nerds = Repo.all(Nerd)
    render conn, "index.html", nerds: nerds
  end
end
