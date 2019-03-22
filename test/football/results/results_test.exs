defmodule Football.ResultsTest do
  use Football.DataCase

  alias Football.Results

  describe "results" do
    alias Football.Results.Result

    @valid_attrs %{
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

    def result_fixture(attrs \\ %{}) do
      {:ok, result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Results.create_result()

      result
    end

    test "list_results/0 returns all results" do
      result = result_fixture()
      assert Results.list_results() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert Results.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      assert {:ok, %Result{} = result} = Results.create_result(@valid_attrs)
      assert result.away_team == "some away_team"
      assert result.date == ~D[2010-04-17]
      assert result.div == "some div"
      assert result.ftag == 42
      assert result.fthg == 42
      assert result.ftr == "some ftr"
      assert result.home_team == "some home_team"
      assert result.htag == 42
      assert result.hthg == 42
      assert result.htr == "some htr"
      assert result.season == "some season"
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Results.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      assert {:ok, %Result{} = result} = Results.update_result(result, @update_attrs)
      assert result.away_team == "some updated away_team"
      assert result.date == ~D[2011-05-18]
      assert result.div == "some updated div"
      assert result.ftag == 43
      assert result.fthg == 43
      assert result.ftr == "some updated ftr"
      assert result.home_team == "some updated home_team"
      assert result.htag == 43
      assert result.hthg == 43
      assert result.htr == "some updated htr"
      assert result.season == "some updated season"
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = Results.update_result(result, @invalid_attrs)
      assert result == Results.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = Results.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Results.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = Results.change_result(result)
    end
  end
end
