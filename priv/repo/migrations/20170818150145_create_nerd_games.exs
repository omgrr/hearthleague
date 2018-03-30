defmodule Hearthleague.Repo.Migrations.CreateNerdGames do
  use Ecto.Migration

  def change do
    create table(:nerd_games) do
      add :nerd_id, :integer
      add :game_id, :integer

      timestamps()
    end

  end
end
