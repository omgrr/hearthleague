defmodule Hearthleague.Repo.Migrations.CreateNerdSeasons do
  use Ecto.Migration

  def change do
    create table(:nerd_seasons) do
      add :nerd_id, :integer
      add :season_id, :integer

      timestamps()
    end

  end
end
