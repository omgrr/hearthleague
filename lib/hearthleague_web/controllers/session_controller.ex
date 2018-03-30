defmodule HearthleagueWeb.SessionController do
  use HearthleagueWeb, :controller

	alias Hearthleague.Nerd
	alias Hearthleague.Session

	plug HearthleagueWeb.Plug.Authentication when action in [:new, :create]

  def new(conn, _params) do
    render conn, "new.html"
  end

	def create(conn, %{"session" => session_params}) do
		nerd = Repo.get_by(Nerd, email: String.downcase(session_params["email"]))

		case Session.login(nerd, session_params["password"]) do
			{:ok, nerd} ->
				conn
					|> put_session(:current_nerd, nerd.id)
					|> put_flash(:info, "Logged in, you fucking nerd")
					|> redirect(to: "/")
			:error ->
				conn
					|> put_flash(:info, "You're bad at this")
					|> render("new.html")
		end
	end

	def delete(conn, _params) do
		conn
			|> delete_session(:current_nerd)
			|> put_flash(:info, "Byeeeeeeeeeee")
			|> redirect(to: "/")
	end
end
