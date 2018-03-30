defmodule HearthleagueWeb.Plug.Authentication do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _) do
		case get_session(conn, :current_nerd) do
			nil -> conn
			_ ->
				conn
					|> put_flash(:info, "You are already logged in")
					|> redirect(to: "/")
					|> halt()
		end
  end
end
