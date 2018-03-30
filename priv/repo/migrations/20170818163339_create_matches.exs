defmodule Hearthleague.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :winning_player_id, :integer
      add :losing_player_id, :integer

      timestamps()
    end

  end
end
