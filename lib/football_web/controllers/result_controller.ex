defmodule FootballWeb.ResultController do
  use FootballWeb, :controller

  alias Football.Results
  alias Football.Results.Result

  action_fallback FootballWeb.FallbackController

  def index(conn, _params) do
    results = Results.list_results()
    render(conn, "index.json", results: results)
  end

  # def index(conn, %{"" => }) do
  #   results = Results.list_results()
  #   render(conn, "index.json", results: results)
  # end

  # def index(conn, _params) do
  #   results = Results.list_results()
  #   render(conn, "index.json", results: results)
  # end

  def show(conn, %{"id" => id}) do
    result = Results.get_result!(id)
    render(conn, "show.json", result: result)
  end
end
