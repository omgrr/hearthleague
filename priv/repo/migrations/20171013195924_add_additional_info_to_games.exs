defmodule Hearthleague.Repo.Migrations.AddAdditionalInfoToGames do
  use Ecto.Migration

  def change do
    alter table(:nerd_games) do
      add :deck, :string
    end

    alter table(:games) do
      add :winning_nerd_id, :integer
    end
  end
end
