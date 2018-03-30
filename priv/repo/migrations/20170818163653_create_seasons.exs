defmodule Hearthleague.Repo.Migrations.CreateSeasons do
  use Ecto.Migration

  def change do
    create table(:seasons) do
      add :name, :string

      timestamps()
    end

  end
end
