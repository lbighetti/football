defmodule FootballWeb.ResultView do
  use FootballWeb, :view
  alias FootballWeb.ResultView

  def render("index.json", %{results: results}) do
    %{data: render_many(results, ResultView, "result.json")}
  end

  def render("show.json", %{result: result}) do
    %{data: render_one(result, ResultView, "result.json")}
  end

  def render("result.json", %{result: result}) do
    %{
      id: result.id,
      div: result.div,
      season: result.season,
      date: result.date,
      home_team: result.home_team,
      away_team: result.away_team,
      fthg: result.fthg,
      ftag: result.ftag,
      ftr: result.ftr,
      hthg: result.hthg,
      htag: result.htag,
      htr: result.htr
    }
  end
end
