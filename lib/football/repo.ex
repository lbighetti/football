defmodule Football.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :football,
    adapter: Ecto.Adapters.Postgres

  def init(_type, opts) do
    {:ok, Keyword.merge(opts, Confex.get_env(:football, Football.Repo))}
  end
end
