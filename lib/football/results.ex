defmodule Football.Results do
  @moduledoc """
  The Results context.
  """

  import Ecto.Query, warn: false
  alias Football.Repo

  alias Football.Results.Result

  @doc """
  Returns the list of results.

  ## Examples

      iex> list_results()
      [%Result{}, ...]

  """
  def list_results do
    Repo.all(Result)
  end

  def list_results_by_season(season) do
    query = from r in Result,
          where: r.season == ^season
    Repo.all(query)
  end

  def list_results_by_league(league) do
    query = from r in Result,
          where: r.div == ^league
    Repo.all(query)
  end

  def list_results_by_season_and_league(season, league) do
    query = from r in Result,
          where: r.season == ^season and r.div == ^league
    Repo.all(query)
  end
end
