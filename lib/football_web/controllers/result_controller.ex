defmodule FootballWeb.ResultController do
  @moduledoc false
  use FootballWeb, :controller
  use PhoenixSwagger

  alias Football.Results
  alias Football.Results.ProtobufMsgs

  def swagger_definitions do
    %{
      Result:
        swagger_schema do
          title("Result")
          description("A result from a football match")

          properties do
            id(:integer, "Result ID")
            div(:string, "The football league and/or division")
            season(:string, "The season the match took place in")
            date(:string, "The date of the match")
            home_team(:string, "Name of the team playing at home")
            away_team(:string, "Name of the team playing away")
            ftag(:integer, "Full time away team goals")
            fthg(:integer, "Full time home team goals")
            ftr(:string, "Full time results.")
            htag(:integer, "Half time away team goals")
            hthg(:integer, "Half time home team goals")
            htr(:string, "Half time results.")
          end

          example(%{
            id: 1,
            div: "SP1",
            season: "201617",
            date: "2016-01-03",
            home_team: "La Cor",
            away_team: "Eibar",
            ftag: 1,
            fthg: 2,
            ftr: "H",
            htag: 0,
            hthg: 0,
            htr: "D"
          })
        end,
      Response:
        swagger_schema do
          title("Response")
          description("Response schema for multiple football matches results")
          property(:data, Schema.array(:Result), "The results from football matches")
        end
    }
  end

  swagger_path(:protobuf_index) do
    get("/api/p/results")
    summary("List Results in protocol buffers")
    description("List all results in the database")
    produces("application/x-protobuf")
    deprecated(false)

    parameter(:season, :query, :string, "The season the match occured in",
      required: false,
      example: "201617"
    )

    parameter(:league, :query, :string, "The league where the team plays",
      required: false,
      example: "SP1"
    )

    response(200, "OK", Schema.ref(:Response),
      example: %{
        data: [
          %{
            id: 1,
            div: "SP1",
            season: "201617",
            date: "2016-01-03",
            home_team: "La Cor",
            away_team: "Eibar",
            ftag: 1,
            fthg: 2,
            ftr: "H",
            htag: 0,
            hthg: 0,
            htr: "D"
          },
          %{
            id: 2,
            div: "SP1",
            season: "201617",
            date: "2016-08-19",
            home_team: "Malaga",
            away_team: "Eibar",
            ftag: 1,
            fthg: 1,
            ftr: "D",
            htag: 0,
            hthg: 0,
            htr: "D"
          }
        ]
      }
    )
  end

  def protobuf_index(conn, %{"season" => season, "league" => league}) do
    results =
      Results.list_results_by_season_and_league(season, league)
      |> parse_to_protobuf_struct

    protobuf_response = ProtobufMsgs.Response.new(data: results)
    encoded = ProtobufMsgs.Response.encode(protobuf_response)

    conn
    |> put_resp_content_type("application/x-protobuf")
    |> send_resp(200, encoded)
  end

  def protobuf_index(conn, %{"season" => season}) do
    results =
      Results.list_results_by_season(season)
      |> parse_to_protobuf_struct

    protobuf_response = ProtobufMsgs.Response.new(data: results)
    encoded = ProtobufMsgs.Response.encode(protobuf_response)

    conn
    |> put_resp_content_type("application/x-protobuf")
    |> send_resp(200, encoded)
  end

  def protobuf_index(conn, %{"league" => league}) do
    results =
      Results.list_results_by_league(league)
      |> parse_to_protobuf_struct

    protobuf_response = ProtobufMsgs.Response.new(data: results)
    encoded = ProtobufMsgs.Response.encode(protobuf_response)

    conn
    |> put_resp_content_type("application/x-protobuf")
    |> send_resp(200, encoded)
  end

  def protobuf_index(conn, _params) do
    results =
      Results.list_results()
      |> parse_to_protobuf_struct

    protobuf_response = ProtobufMsgs.Response.new(data: results)
    encoded = ProtobufMsgs.Response.encode(protobuf_response)

    conn
    |> put_resp_content_type("application/x-protobuf")
    |> send_resp(200, encoded)
  end

  defp parse_to_protobuf_struct(results) do
    results
    |> Enum.map(fn r ->
      Map.from_struct(r)
      |> Map.put(:date, to_string(r.date))
      |> Map.delete(:__meta__)
      |> ProtobufMsgs.Result.new()
    end)
  end

  swagger_path(:index) do
    get("/api/results")
    summary("List Results in JSON format")
    description("List all results in the database")
    produces("application/json")
    deprecated(false)

    parameter(:season, :query, :string, "The season the match occured in",
      required: false,
      example: "201617"
    )

    parameter(:league, :query, :string, "The league where the team plays",
      required: false,
      example: "SP1"
    )

    response(200, "OK", Schema.ref(:Response),
      example: %{
        data: [
          %{
            id: 1,
            div: "SP1",
            season: "201617",
            date: "2016-01-03",
            home_team: "La Cor",
            away_team: "Eibar",
            ftag: 1,
            fthg: 2,
            ftr: "H",
            htag: 0,
            hthg: 0,
            htr: "D"
          },
          %{
            id: 2,
            div: "SP1",
            season: "201617",
            date: "2016-08-19",
            home_team: "Malaga",
            away_team: "Eibar",
            ftag: 1,
            fthg: 1,
            ftr: "D",
            htag: 0,
            hthg: 0,
            htr: "D"
          }
        ]
      }
    )
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
