defmodule Football.Repo.Migrations.CreateResults do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :div, :string
      add :season, :string
      add :date, :date
      add :home_team, :string
      add :away_team, :string
      add :fthg, :integer
      add :ftag, :integer
      add :ftr, :string
      add :hthg, :integer
      add :htag, :integer
      add :htr, :string
    end
  end
end
