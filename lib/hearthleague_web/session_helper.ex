defmodule HearthleagueWeb.SessionHelper do
  alias Hearthleague.Repo
  alias Hearthleague.Nerd

  def current_nerd(conn) do
    id = Plug.Conn.get_session(conn, :current_nerd)
    case id do
      nil -> nil
      _ -> Repo.get(Nerd, id)
    end
  end

  def logged_in?(conn), do: !!current_nerd(conn)
end
