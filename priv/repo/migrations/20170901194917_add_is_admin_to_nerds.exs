defmodule Hearthleague.Repo.Migrations.AddIsAdminToNerds do
  use Ecto.Migration

  def change do
    alter table(:nerds) do
      add :is_admin, :boolean
    end
  end
end
