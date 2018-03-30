defmodule Hearthleague.Repo.Migrations.CreateNerds do
  use Ecto.Migration

  def change do
    create table(:nerds) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
