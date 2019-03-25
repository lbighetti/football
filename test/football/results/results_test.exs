defmodule Football.ResultsTest do
  use Football.DataCase

  alias Football.Results

  @season_2016_2017 "201617"
  @league "SP1"

  describe "results" do

    test "available" do
      results = Results.list_available()
      assert results == [
        %{div: "SP1", season: "201617"},
        %{div: "SP1", season: "201516"},
        %{div: "SP2", season: "201617"},
        %{div: "SP2", season: "201516"},
        %{div: "E0", season: "201617"},
        %{div: "D1", season: "201617"}
      ]
    end

    test "list_results/0 returns all results" do
      results = Results.list_results()
      assert results != []
    end

    test "list_results_by_season_and_league/1 returns correct results" do
      results =
        @season_2016_2017
        |> Results.list_results_by_season_and_league(@league)

      assert Enum.all?(results, fn result ->
               result.date.year == 2016 or result.date.year == 2017
             end)

      assert Enum.all?(results, fn result -> result.div == "SP1" end)
    end

    test "list_results_by_season/1 returns correct results" do
      @season_2016_2017
      |> Results.list_results_by_season()
      |> Enum.all?(fn result -> result.date.year == 2016 or result.date.year == 2017 end)
      |> assert
    end

    test "list_results_by_league/1 returns correct results" do
      @league
      |> Results.list_results_by_season()
      |> Enum.all?(fn result -> result.div == "SP1" end)
      |> assert
    end
  end
end
