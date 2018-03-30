defmodule Hearthleague.Repo.Migrations.RemoveTimeColumnsFromNerdSeasons do
  use Ecto.Migration

  def change do
    alter table(:nerd_seasons) do
      remove :updated_at
      remove :inserted_at
    end
  end
end
