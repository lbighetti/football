defmodule FootballWeb.ResultControllerTest do
  use FootballWeb.ConnCase

  alias Football.Results
  alias Football.Results.Result

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all results", %{conn: conn} do
      conn = get(conn, Routes.result_path(conn, :index))
      assert json_response(conn, 200)["data"] != []
    end
  end

end
