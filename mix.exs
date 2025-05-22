defmodule NBA.MixProject do
  use Mix.Project

  def project do
    [
      app: :nba_api,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "NBA API EX",
      source_url: "https://github.com/jmoletteire/nba_api_ex",
      homepage_url: "https://github.com/jmoletteire/nba_api_ex",
      docs: [main: "NBA"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {NBA.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:req, "~> 0.4"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false},
      {:castore, "~> 1.0"}
    ]
  end
end
