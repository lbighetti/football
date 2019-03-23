defmodule FootballWeb.ResultControllerTest do
  use FootballWeb.ConnCase
  import ProtoResponse

  @total_test_entries 2370
  @sp1_entries 760
  @sp1_league "SP1"
  @season_2016_2017 "201617"
  @season_2016_2017_entries 1528
  @sp1_season_2016_2017_entries 380

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "json api" do
    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :index))
      results = json_response(conn, 200)["data"]
      assert length(results) == @total_test_entries
    end

    test "lists results filter by league", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :index), league: @sp1_league)
      results = json_response(conn, 200)["data"]
      [first_result | _other_results] = results
      assert first_result["div"] == "SP1"
      assert length(results) == @sp1_entries
    end

    test "lists results filter by season", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :index), season: @season_2016_2017)
      results = json_response(conn, 200)["data"]
      [first_result | _other_results] = results
      assert first_result["season"] == "201617"
      assert length(results) == @season_2016_2017_entries
    end

    test "lists results filter by season and league", %{conn: conn} do
      conn =
        get(conn, Routes.result_path(conn, :index), %{
          season: @season_2016_2017,
          league: @sp1_league
        })

      results = json_response(conn, 200)["data"]
      [first_result | _other_results] = results
      assert first_result["season"] == "201617"
      assert first_result["div"] == "SP1"
      assert length(results) == @sp1_season_2016_2017_entries
    end
  end

  describe "protobuf api" do
    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :protobuf_index))
      response = proto_response(conn, 200, Football.Results.ProtobufMsgs.Response)
      assert length(response.data) == @total_test_entries
    end
  end
end
