defmodule HearthleagueWeb.SeasonView do
  use HearthleagueWeb, :view

  def matches_won_by_nerd(season, nerd) do
    season.matches |> Enum.filter(&(&1.winning_nerd_id == nerd.id)) |> Enum.count
  end

  def games_won_by_nerd(season, nerd) do
    season.matches
      |> Enum.map(&(&1.games))
      |> List.flatten
      |> Enum.filter(&(&1.winning_nerd_id == nerd.id))
      |> Enum.count
  end
end
