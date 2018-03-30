defmodule Hearthleague.Nerd do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hearthleague.Nerd
  alias Hearthleague.Game


  schema "nerds" do
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :email, :string
    field :name, :string
    field :is_admin, :boolean
    many_to_many :games, Game, join_through: "nerd_games"

    timestamps()
  end

  @doc false
  def changeset(%Nerd{} = nerd, attrs) do
    nerd
    |> cast(attrs, [:name, :email, :password, :id])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
