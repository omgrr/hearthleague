defmodule HearthleagueWeb.MatchView do
  use HearthleagueWeb, :view

  def game_select_options(nerds, game) do
    nerd_ids = Enum.map(nerds, fn(nerd) ->
      if game.winning_nerd_id == nerd.id do
        [key: nerd.name, value: nerd.id, selected: true]
      else
        [key: nerd.name, value: nerd.id]
      end
    end)

    nerd_ids ++ [[key: '--', value: "", selected: game.winning_nerd_id == ""]]
  end
end
