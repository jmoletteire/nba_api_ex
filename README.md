# Elixir NBA API

An Elixir client for interacting with the NBA's public and semi-public APIs, inspired by the Python [`nba_api`](https://github.com/swar/nba_api) package.

This package aims to make it easy to query NBA data (e.g., player awards, live scores, stats) from both `stats.nba.com` and `cdn.nba.com`, with support for features like:

- Modular endpoint access via `NBA.API.Stats` and `NBA.API.Live`
- JSON parsing and structured results
- Retry and error handling built in
- Proxy support (e.g., BrightData)
- Extensible endpoint modules

⚠️ This is a work-in-progress and currently includes basic support for endpoints like `playerawards`.

---

## Installation

> **Note:** This package is not yet published to Hex. You can clone and use it locally in development:

```elixir
def deps do
  [
    {:nba_api, path: "../nba_api_ex"} # Adjust the path as needed
  ]
end
```

## Usage

Example:

```elixir
NBA.PlayerAwards.get(2544)
# => {:ok, %{"PlayerAwards" => [...]}}
```

## Docs

Once the package is published to Hex, documentation will be available at hexdocs.pm/nba_api.

Until then, you can generate local docs with:

```
mix docs
```

## License

See the LICENSE file for details.
