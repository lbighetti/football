defmodule FootballWeb.ResultController do
  use FootballWeb, :controller

  alias Football.Results
  alias Football.Results.ProtobufMsgs

  action_fallback FootballWeb.FallbackController

  def protobuf_index(conn, _params) do
    results =
      Results.list_results()
      |> Enum.map(fn r ->
        Map.from_struct(r)
        |> Map.put(:date, to_string(r.date))
        |> Map.delete(:__meta__)
        |> ProtobufMsgs.Result.new()
      end)

    p_response = ProtobufMsgs.Response.new(data: results)
    encoded = ProtobufMsgs.Response.encode(p_response)

    conn
    |> put_resp_content_type("application/x-protobuf")
    |> send_resp(200, encoded)
  end

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