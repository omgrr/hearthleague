defmodule Hearthleague.Repo.Migrations.AddSeasonIdToMatchesAndRemoveItFromSeason do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :season_id, :integer
    end

    alter table(:seasons) do
      remove :season_id
    end
  end
end
