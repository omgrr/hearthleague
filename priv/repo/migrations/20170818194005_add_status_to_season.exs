defmodule Hearthleague.Repo.Migrations.AddStatusToSeason do
  use Ecto.Migration

  def change do
    alter table(:seasons) do
      add :status, :string
    end
  end
end
