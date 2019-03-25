defmodule FootballWeb.ResultView do
  @moduledoc false
  use FootballWeb, :view
  alias FootballWeb.ResultView

  def render("available_list.json", %{results: results}) do
    %{data: render_many(results, ResultView, "available.json")}
  end

  def render("available.json", %{result: result}) do
    %{
      div: result.div,
      season: result.season,
    }
  end

  def render("index.json", %{results: results}) do
    %{data: render_many(results, ResultView, "result.json")}
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
