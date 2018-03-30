defmodule Hearthleague.Repo.Migrations.AddSeasonIdToMatch do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :match_id, :integer
    end
  end
end
