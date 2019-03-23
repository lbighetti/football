defmodule Football.MixProject do
  use Mix.Project

  def project do
    [
      app: :football,
      version: "1.0.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext, :phoenix_swagger] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      mod: {Football.Application, []},
      extra_applications: [:logger, :runtime_tools, :exprotobuf]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:csv, "~> 2.3"},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:exprotobuf, "~> 1.2.9"},
      {:proto_response, "~> 0.3.0"},
      {:phoenix_swagger, "~> 0.8"},
      {:ex_json_schema, "~> 0.5"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: [
        "ecto.drop",
        "ecto.create --quiet",
        "ecto.migrate",
        "run priv/repo/seeds.exs",
        "test"
      ]
    ]
  end
end
