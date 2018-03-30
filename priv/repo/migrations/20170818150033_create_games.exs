defmodule Hearthleague.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :match_id, :integer

      timestamps()
    end

  end
end
