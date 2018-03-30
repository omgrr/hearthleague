defmodule Hearthleague.NerdMatch do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hearthleague.NerdMatch


  schema "nerd_seasons" do
    field :nerd_id, :integer
    field :match_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%NerdMatch{} = nerd_match, attrs) do
    nerd_match
    |> cast(attrs, [:nerd_id, :match_id])
    |> validate_required([:nerd_id, :match_id])
  end
end
