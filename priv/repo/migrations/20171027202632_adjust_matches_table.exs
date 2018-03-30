defmodule Hearthleague.Repo.Migrations.AdjustMatchesTable do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :winning_nerd_id, :integer
      add :losing_nerd_id, :integer
    end
  end
end
