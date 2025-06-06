defmodule NBA.MixProject do
  use Mix.Project

  def project do
    [
      app: :nba_api_ex,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "Elixir client for NBA.com APIs, inspired by the Python nba_api package.",
      source_url: "https://github.com/jmoletteire/nba_api_ex",
      homepage_url: "https://hexdocs.pm/nba_api_ex",
      docs: [main: "readme", extras: ["README.md"]]
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
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: "nba_api_ex",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jmoletteire/nba_api_ex"}
    ]
  end
end
