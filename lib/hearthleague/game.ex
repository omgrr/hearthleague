defmodule Hearthleague.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hearthleague.Game
  alias Hearthleague.Nerd
  alias Hearthleague.Match


  schema "games" do
    field :winning_nerd_id, :integer
    many_to_many :nerds, Nerd, join_through: "nerd_games"
    belongs_to :match, Match

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:match_id, :winning_nerd_id])
    |> validate_required([:match_id])
    |> handle_associations(attrs)
  end

  defp handle_associations(game, attrs) do
		case Map.fetch(attrs, :nerds) do
			{:ok, nerds} -> put_assoc(game, :nerds, nerds)
			:error -> game
		end
	end
end
