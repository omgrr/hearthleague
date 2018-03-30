defmodule Hearthleague.Repo.Migrations.AddUserAuthentication do
  use Ecto.Migration

  def change do
    create unique_index(:nerds, [:email])

    alter table(:nerds) do
      add :encrypted_password, :string
    end
  end
end
