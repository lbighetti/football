defmodule FootballWeb.ResultControllerTest do
  use FootballWeb.ConnCase

  alias Football.Results
  alias Football.Results.Result

  @create_attrs %{
    away_team: "some away_team",
    date: ~D[2010-04-17],
    div: "some div",
    ftag: 42,
    fthg: 42,
    ftr: "some ftr",
    home_team: "some home_team",
    htag: 42,
    hthg: 42,
    htr: "some htr",
    season: "some season"
  }
  @update_attrs %{
    away_team: "some updated away_team",
    date: ~D[2011-05-18],
    div: "some updated div",
    ftag: 43,
    fthg: 43,
    ftr: "some updated ftr",
    home_team: "some updated home_team",
    htag: 43,
    hthg: 43,
    htr: "some updated htr",
    season: "some updated season"
  }
  @invalid_attrs %{
    away_team: nil,
    date: nil,
    div: nil,
    ftag: nil,
    fthg: nil,
    ftr: nil,
    home_team: nil,
    htag: nil,
    hthg: nil,
    htr: nil,
    season: nil
  }

  def fixture(:result) do
    {:ok, result} = Results.create_result(@create_attrs)
    result
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create result" do
    test "renders result when data is valid", %{conn: conn} do
      conn = post(conn, Routes.result_path(conn, :create), result: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.result_path(conn, :show, id))

      assert %{
               "id" => id,
               "away_team" => "some away_team",
               "date" => "2010-04-17",
               "div" => "some div",
               "ftag" => 42,
               "fthg" => 42,
               "ftr" => "some ftr",
               "home_team" => "some home_team",
               "htag" => 42,
               "hthg" => 42,
               "htr" => "some htr",
               "season" => "some season"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.result_path(conn, :create), result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update result" do
    setup [:create_result]

    test "renders result when data is valid", %{conn: conn, result: %Result{id: id} = result} do
      conn = put(conn, Routes.result_path(conn, :update, result), result: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.result_path(conn, :show, id))

      assert %{
               "id" => id,
               "away_team" => "some updated away_team",
               "date" => "2011-05-18",
               "div" => "some updated div",
               "ftag" => 43,
               "fthg" => 43,
               "ftr" => "some updated ftr",
               "home_team" => "some updated home_team",
               "htag" => 43,
               "hthg" => 43,
               "htr" => "some updated htr",
               "season" => "some updated season"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, result: result} do
      conn = put(conn, Routes.result_path(conn, :update, result), result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete result" do
    setup [:create_result]

    test "deletes chosen result", %{conn: conn, result: result} do
      conn = delete(conn, Routes.result_path(conn, :delete, result))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.result_path(conn, :show, result))
      end
    end
  end

  defp create_result(_) do
    result = fixture(:result)
    {:ok, result: result}
  end
end
