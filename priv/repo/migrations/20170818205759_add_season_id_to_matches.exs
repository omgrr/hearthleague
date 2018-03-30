defmodule Hearthleague.Repo.Migrations.AddSeasonIdToMatches do
  use Ecto.Migration

  def change do
    alter table(:seasons) do
      add :season_id, :integer
    end
  end
end
