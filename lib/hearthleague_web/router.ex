defmodule HearthleagueWeb.Router do
  use HearthleagueWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HearthleagueWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/nerds", NerdController, :index
		resources "/seasons", SeasonController
    resources "/registrations", RegistrationController, only: [:new, :create]
    resources "/matches", MatchController, only: [:edit, :update]
    resources "/games", GameController, only: [:update]

		get "/login", SessionController, :new
		post "/login", SessionController, :create
		delete "/logout", SessionController, :delete
  end
end
