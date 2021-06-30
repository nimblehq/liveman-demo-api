defmodule Liveman.MixProject do
  use Mix.Project

  def project do
    [
      app: :liveman,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        lint: :test,
        coverage: :test,
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Liveman.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib", "test/support/factories"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:credo, "~> 1.5.6", [only: [:dev, :test], runtime: false]},
      {:dialyxir, "~> 1.1.0", [only: [:dev], runtime: false]},
      {:exvcr, "~> 0.12.3", [only: :test]},
      {:ecto_sql, "~> 3.4"},
      {:ex_machina, "~> 2.7.0"},
      {:excoveralls, "~> 0.14.1", [only: :test]},
      {:faker, "~> 0.16.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:jsonapi, git: "https://github.com/jeregrine/jsonapi.git", branch: "master"},
      {:mimic, "~> 1.5.0", [only: :test]},
      {:phoenix, "~> 1.5.9"},
      {:phoenix_ecto, "~> 4.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:plug_cowboy, "~> 2.0"},
      {:sobelow, "~> 0.11", [only: [:dev, :test], runtime: false]},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      coverage: ["coveralls.html --raise"],
      codebase: [
        "deps.unlock --check-unused",
        "format --check-formatted",
        "credo --strict",
        "sobelow --config"
      ],
      "codebase.fix": ["deps.clean --unlock --unused", "format"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "gettext.extract-and-merge": ["gettext.extract --merge"],
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
