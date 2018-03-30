defmodule Hearthleague.Repo.Migrations.RemoveWinninerPlayerIdAndLosingPlayerId do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      remove :winning_player_id
      remove :losing_player_id
    end
  end
end
