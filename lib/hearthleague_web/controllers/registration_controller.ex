defmodule HearthleagueWeb.RegistrationController do
  use HearthleagueWeb, :controller

	alias Hearthleague.Registration
  alias Hearthleague.Nerd

	plug HearthleagueWeb.Plug.Authentication

  def new(conn, _params) do
    changeset = Nerd.changeset(%Nerd{}, %{})
    render conn, changeset: changeset
  end

  def create(conn, %{"nerd" => nerd_params}) do
		changeset = Nerd.changeset(%Nerd{}, nerd_params)
		result = changeset
			|> Registration.add_hashed_password
			|> Repo.insert

		case result do
			{:ok, nerd} ->
				conn
          |> put_session(:current_nerd, nerd.id)
          |> put_flash(:info, "Nerd registered successfully")
          |> redirect(to: "/")
			{:error, changeset} ->
				render(conn, "new.html", changeset: changeset)
		end
  end
end
