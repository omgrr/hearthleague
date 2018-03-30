defmodule Hearthleague.NerdGame do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hearthleague.NerdGame


  schema "nerd_games" do
    field :game_id, :integer
    field :nerd_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%NerdGame{} = nerd_game, attrs) do
    nerd_game
    |> cast(attrs, [:nerd_id, :game_id])
    |> validate_required([:nerd_id, :game_id])
  end
end
