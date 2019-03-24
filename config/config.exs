# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :football,
  ecto_repos: [Football.Repo]

# Configure your database
config :football, Football.Repo,
  username: {:system, "DATABASE_USERNAME", "postgres"},
  password: {:system, "DATABASE_PASSWORD", "postgres"},
  database: {:system, "DATABASE", "football_dev"},
  hostname: {:system, "DATABASE_HOSTNAME", "localhost"},
  pool_size: {:system, :integer, "DATABASE_POOL_SIZE", 10}

# Configures the endpoint
config :football, FootballWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ndfSPXnx8XhcBoNvRxRvVD2XDLfudYylHmfN8UpIcew/Urlx01R/ZURZJknVr9Xt",
  render_errors: [view: FootballWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Football.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :football, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: FootballWeb.Router,
      # (optional) endpoint config used to set host, port and https schemes.
      endpoint: FootballWeb.Endpoint
    ]
  }
