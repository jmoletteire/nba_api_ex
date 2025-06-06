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

⚠️ This project is a work-in-progress, but already supports dozens of endpoints with full parameter coverage and comprehensive tests.

---

## Installation

> **Note:** This package is not yet published to Hex. You can clone and use it locally in development:

```elixir
def deps do
  [
    {:nba_api_ex, path: "../nba_api_ex"} # Adjust the path as needed
  ]
end
```

## Usage

Each endpoint is available as a module under `NBA.Stats`. All parameters are passed as a keyword list, with defaults and valuesets documented in each module.

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

## Docs

You can generate local docs with:

```
mix docs
```

Once the package is published to Hex, documentation will be available at hexdocs.pm/nba_api.

## License

See the LICENSE file for details.
