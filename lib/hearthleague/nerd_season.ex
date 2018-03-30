defmodule Hearthleague.NerdSeason do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hearthleague.NerdSeason


  schema "nerd_seasons" do
    field :nerd_id, :integer
    field :season_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%NerdSeason{} = nerd_season, attrs) do
    nerd_season
    |> cast(attrs, [:nerd_id, :season_id])
    |> validate_required([:nerd_id, :season_id])
  end
end
