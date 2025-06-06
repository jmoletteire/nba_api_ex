# nba_api_ex

An Elixir client for interacting with the NBA's public and semi-public APIs, inspired by the Python [`nba_api`](https://github.com/swar/nba_api) package.

This package provides comprehensive, modular access to a wide range of NBA data endpoints from both `stats.nba.com` and `cdn.nba.com`, including:

- Player, team, and league stats (regular season, playoffs, advanced, hustle, clutch, etc.)
- Game logs, play-by-play, shot charts, and win probability
- Awards, lineups, matchups, and historical data
- Video metadata and asset endpoints
- And much more, closely following the official NBA API parameter lists and conventions

**Features:**

- Modular endpoint modules under `NBA.Stats` and `NBA.Live` (e.g., `NBA.Stats.TeamGameLogs`, `NBA.Live.Scoreboard`)
- All parameters, types, defaults, and valuesets are documented per endpoint
- Consistent, well-tested interface for all endpoints
- JSON parsing and structured results
- Retry and error handling built in

---

## Installation

Add to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:nba_api_ex, "~> 0.1.0"}
  ]
end
```

Then run:

```
mix deps.get
```

## Usage

Each endpoint is available as a module under `NBA.Stats` or `NBA.Live`. All parameters are passed as a keyword list, with defaults and valuesets documented in each module.

Example:

```elixir
NBA.Stats.TeamGameLogs.get(TeamID: 1610612744, Season: "2024-25")
# => {:ok, %{"TeamGameLogs" => [...]}}

NBA.Live.Scoreboard.get()
# => {:ok, [%{"gameId" => "0042400311", ...}, ...]}
```

Bang(!) Example:

```elixir
NBA.Stats.TeamGameLogs.get!(TeamID: 1610612744, Season: "2024-25")
# => %{"TeamGameLogs" => [...]}

NBA.Live.Scoreboard.get!()
# => [%{"gameId" => "0042400311", ...}, ...]
```

See the module docs for each endpoint for full parameter details and examples.

## Documentation

Full documentation is available at [https://hexdocs.pm/nba_api_ex](https://hexdocs.pm/nba_api_ex).

You can also generate local docs with:

```
mix docs
```

## License

See the LICENSE file for details.
