# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Football.Repo.insert!(%Football.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Football.Results.Result
alias Football.Repo

File.stream!("Data.csv")
|> CSV.decode!()
|> Stream.drop(1)
|> Stream.map(fn [_id, div, season, date, home_team, away_team, ftag, fthg, ftr, htag, hthg, htr] ->
  Result.import_changeset(%{
    div: div,
    season: season,
    date:
      Date.from_iso8601!(
        "#{String.slice(date, 6..9)}-#{String.slice(date, 3..4)}-#{String.slice(date, 0..1)}"
      ),
    home_team: home_team,
    away_team: away_team,
    ftag: ftag,
    fthg: fthg,
    ftr: ftr,
    htag: htag,
    hthg: hthg,
    htr: htr
  })
end)
|> Enum.map(fn changeset -> Repo.insert!(changeset) end)
