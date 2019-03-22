defmodule Football.ResultsTest do
  use Football.DataCase

  alias Football.Results

  describe "results" do
    alias Football.Results.Result

    test "list_results/0 returns all results" do
      results = Results.list_results()
    end

  end
end
