defmodule Football.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Confex.resolve_env!(:football)

    # AppSignal Ecto setup
    :telemetry.attach(
      "appsignal-ecto",
      [:my_app, :repo, :query],
      &Appsignal.Ecto.handle_event/4,
      nil
    )
    children = [
      Football.Repo,
      FootballWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Football.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FootballWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
