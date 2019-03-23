defmodule Football.Results.Result do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__

  @fields ~w(div season date home_team away_team fthg ftag ftr hthg htag htr)a

  schema "results" do
    field :div, :string
    field :season, :string
    field :date, :date
    field :home_team, :string
    field :away_team, :string
    field :ftag, :integer
    field :fthg, :integer
    field :ftr, :string
    field :htag, :integer
    field :hthg, :integer
    field :htr, :string
  end

  @doc false
  def import_changeset(attrs) do
    %Result{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
