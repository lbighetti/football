defmodule FootballWeb.ResultController do
  use FootballWeb, :controller

  alias Football.Results

  action_fallback FootballWeb.FallbackController

  def index(conn, %{"season" => season, "league" => league}) do
    results = Results.list_results_by_season_and_league(season, league)
    render(conn, "index.json", results: results)
  end

  def index(conn, %{"season" => season}) do
    results = Results.list_results_by_season(season)
    render(conn, "index.json", results: results)
  end

  def index(conn, %{"league" => league}) do
    results = Results.list_results_by_league(league)
    render(conn, "index.json", results: results)
  end

  def index(conn, _params) do
    results = Results.list_results()
    render(conn, "index.json", results: results)
  end
end
