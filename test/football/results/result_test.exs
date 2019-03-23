defmodule Football.ResultTest do
  use Football.DataCase

  alias Football.Results.Result

  @valid_attrs %{
    div: "SP1",
    season: "201617",
    date: "2016-01-12",
    home_team: "La Coruna",
    away_team: "Granada",
    ftag: 3,
    fthg: 1,
    ftr: "A",
    htag: 1,
    hthg: 1,
    htr: "D"
  }

  @invalid_attrs %{
    div: "SP1",
    season: "201617",
    date: "2016/01/02",
    home_team: "La Coruna",
    away_team: "Granada",
    ftag: "S",
    fthg: nil,
    ftr: "A",
    htag: 1,
    hthg: 1,
    htr: "D"
  }

  test "changeset/1 with valid data" do
    changeset = Result.changeset(@valid_attrs)
    assert changeset.valid?
  end

  test "changeset/1 with invalid data" do
    changeset = Result.changeset(@invalid_attrs)
    refute changeset.valid?

    assert %{date: ["is invalid"], ftag: ["is invalid"], fthg: ["can't be blank"]} =
             errors_on(changeset)
  end
end
