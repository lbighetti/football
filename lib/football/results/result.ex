defmodule Football.Results.Result do
  @moduledoc """
  The Ecto.Schema for Result

  This symbolizes the result for one football match.
  """
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

  @type div :: String.t
  @type season :: String.t

  @typedoc """
  The Result struct.

  It contains keys as folows:

  * `:div`: The code to identify the league being played. E.g.: `"SP1"` for La Liga, `"SP2"` for La Liga 2.
  * `:season`: Which season the match took place in, in the format `"201617"`.
  * `:date`: Date of the match.
  * `:home_team`: Team which is playing at home.
  * `:away_team`: Team which is playing away from home.
  * `:ftag`: Full time away goals.
  * `:fthg`: full time home goals.
  * `:ftr`: Full time results.
  * `:htag`: Half time away goals.
  * `:hthg`: Half time home goals.
  * `:htr`: Half time results.
  """
  @type t :: %__MODULE__{
    div: div,
    season: season,
    date: Date.t,
    home_team: String.t,
    away_team: String.t,
    ftag: non_neg_integer,
    fthg: non_neg_integer,
    ftr: String.t,
    htag: non_neg_integer,
    hthg: non_neg_integer,
    htr: String.t
  }

  @doc false
  def changeset(attrs) do
    %Result{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
