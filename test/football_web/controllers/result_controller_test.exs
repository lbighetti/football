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
    test "lists seasons and leagues available", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :available))
      results = json_response(conn, 200)["data"]
      assert results == [
        %{"div" => "SP1", "season" => "201617"},
        %{"div" => "SP1", "season" => "201516"},
        %{"div" => "SP2", "season" => "201617"},
        %{"div" => "SP2", "season" => "201516"},
        %{"div" => "E0", "season" => "201617"},
        %{"div" => "D1", "season" => "201617"}
      ]
    end

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
    test "lists all avaiable season and league", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :protobuf_available))
      response = proto_response(conn, 200, Football.Results.ProtobufMsgs.AvailableResponse)
      assert response.data == [
        %Football.Results.ProtobufMsgs.Available{div: "SP1", season: "201617"},
        %Football.Results.ProtobufMsgs.Available{div: "SP1", season: "201516"},
        %Football.Results.ProtobufMsgs.Available{div: "SP2", season: "201617"},
        %Football.Results.ProtobufMsgs.Available{div: "SP2", season: "201516"},
        %Football.Results.ProtobufMsgs.Available{div: "E0", season: "201617"},
        %Football.Results.ProtobufMsgs.Available{div: "D1", season: "201617"}
      ]
    end

    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :protobuf_index))
      response = proto_response(conn, 200, Football.Results.ProtobufMsgs.Response)
      assert length(response.data) == @total_test_entries
    end

    test "lists results filter by league", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :protobuf_index), league: @sp1_league)
      response = proto_response(conn, 200, Football.Results.ProtobufMsgs.Response)
      results = response.data
      assert length(results) == @sp1_entries
      [first_result | _other_results] = results
      assert first_result.div == "SP1"
    end

    test "lists results filter by season", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :protobuf_index), season: @season_2016_2017)
      response = proto_response(conn, 200, Football.Results.ProtobufMsgs.Response)
      results = response.data
      [first_result | _other_results] = results
      assert first_result.season == "201617"
      assert length(results) == @season_2016_2017_entries
    end

    test "lists results filter by season and league", %{conn: conn} do
      conn =
        get(conn, Routes.result_path(conn, :protobuf_index),
          season: @season_2016_2017,
          league: @sp1_league
        )

      response = proto_response(conn, 200, Football.Results.ProtobufMsgs.Response)
      results = response.data
      [first_result | _other_results] = results
      assert first_result.season == "201617"
      assert first_result.div == "SP1"
      assert length(results) == @sp1_season_2016_2017_entries
    end
  end
end
