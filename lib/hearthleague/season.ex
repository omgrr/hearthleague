defmodule Hearthleague.Season do
  use Ecto.Schema
  import Ecto.Changeset

	alias Hearthleague.Match
	alias Hearthleague.Nerd
  alias Hearthleague.Season

  schema "seasons" do
    field :name, :string
		field :status, :string
    has_many :matches, Match
		many_to_many :nerds, Nerd, join_through: "nerd_seasons"

    timestamps()
  end

  @doc false
  def changeset(%Season{} = season, attrs) do
    season
    |> cast(attrs, [:name, :status])
    |> validate_required([:name])
    |> validate_required([:status])
		|> handle_associations(attrs)
    |> cast_assoc(:matches)
  end

	defp handle_associations(season, attrs) do
		case Map.fetch(attrs, :nerds) do
			{:ok, nerds} -> put_assoc(season, :nerds, nerds)
			:error -> season
		end
	end
end
