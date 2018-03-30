defmodule Hearthleague.Repo.Migrations.RemoveTimestampsFromNerdGames do
  use Ecto.Migration

  def change do
    alter table(:nerd_games) do
      remove :updated_at
      remove :inserted_at
    end
  end
end
