defmodule Hearthleague.Repo.Migrations.RemoveTimestampsFromNerdMatches do
  use Ecto.Migration

  def change do
    alter table(:nerd_matches) do
      remove :updated_at
      remove :inserted_at
    end
  end
end
