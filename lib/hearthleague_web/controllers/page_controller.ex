defmodule HearthleagueWeb.PageController do
  use HearthleagueWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
