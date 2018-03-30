defmodule Hearthleague.Repo.Migrations.AddNerdMatches do
  use Ecto.Migration

  def change do
    create table(:nerd_matches) do
      add :nerd_id, :integer
      add :match_id, :integer

      timestamps()
    end
  end
end
