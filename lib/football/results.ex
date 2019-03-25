defmodule Football.Results do
  @moduledoc """
  The Results context. The main entry point to the `Football` application logic and data.
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
  @spec list_results() :: [Result.t] | []
  def list_results do
    Repo.all(Result)
  end

  @doc """
  Returns the list of results filtered by season.

  ## Examples

      iex> list_results("201617")
      [%Result{}, ...]

  """
  @spec list_results_by_season(Result.season) :: [Result.t] | []
  def list_results_by_season(season) do
    query =
      from r in Result,
        where: r.season == ^season

    Repo.all(query)
  end

  @doc """
  Returns the list of results filtered by league (div).

  ## Examples

      iex> list_results("SP1")
      [%Result{}, ...]

  """
  @spec list_results_by_league(Result.div) :: [Result.t] | []
  def list_results_by_league(league) do
    query =
      from r in Result,
        where: r.div == ^league

    Repo.all(query)
  end

  @doc """
  Returns the list of results filtered by both season and league (div).

  ## Examples

      iex> list_results("201617", "SP1")
      [%Result{}, ...]

  """
  @spec list_results_by_season_and_league(Result.season, Result.div) :: [Result.t] | []
  def list_results_by_season_and_league(season, league) do
    query =
      from r in Result,
        where: r.season == ^season and r.div == ^league

    Repo.all(query)
  end
end
