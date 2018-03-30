defmodule Hearthleague.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hearthleague.Match
  alias Hearthleague.Season
  alias Hearthleague.Nerd
  alias Hearthleague.Game


  schema "matches" do
    field :losing_nerd_id, :integer
    field :winning_nerd_id, :integer
    field :season_id, :integer
		has_one :season, Season
    many_to_many :nerds, Nerd, join_through: "nerd_matches"
    has_many :games, Game

    timestamps()
  end

  @doc false
  def changeset(%Match{} = match, attrs) do
    match
    |> cast(attrs, [:winning_nerd_id, :losing_nerd_id, :season_id])
    |> handle_nerds_association(attrs)
  end

  defp handle_nerds_association(match, attrs) do
    case Map.fetch(attrs, :nerds) do
      {:ok, nerds} -> put_assoc(match, :nerds, nerds)
      :error -> match
    end
  end
end
