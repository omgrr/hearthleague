defmodule Hearthleague.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :player_id, :integer
      add :class, :string

      timestamps()
    end

  end
end
