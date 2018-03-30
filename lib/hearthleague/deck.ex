defmodule Hearthleague.Deck do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hearthleague.Deck


  schema "decks" do
    field :class, :string
    field :player_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Deck{} = deck, attrs) do
    deck
    |> cast(attrs, [:player_id, :class])
    |> validate_required([:player_id, :class])
  end
end
