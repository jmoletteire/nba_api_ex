defmodule NBA.Stats.LeagueSeasonMatchups do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league season matchup.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leagueseasonmatchups"

  @accepted_types %{
    DefPlayerID: [:integer, :string],
    DefTeamID: [:integer, :string],
    LeagueID: [:string],
    OffPlayerID: [:integer, :string],
    OffTeamID: [:integer, :string],
    PerMode: [:string],
    Season: [:string],
    SeasonType: [:string]
  }

  @default [
    LeagueID: "00",
    PerMode: "PerGame",
    Season: nil,
    SeasonType: "Regular Season",
    OffTeamID: nil,
    OffPlayerID: nil,
    DefTeamID: nil,
    DefPlayerID: nil
  ]

  @required [:Season]

  @doc """
  Fetches league season matchups data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LeagueID`: The league ID (e.g., "00" for NBA).
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Pattern_: `^\\d{2}$`

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`

    - `Season`: The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`
      - _Pattern_: `^(\\d{4}-\\d{2})$`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"Pre-Season"`

    - `OffTeamID`: Offensive team ID filter.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OffTeamID: 1610612747`
      - _Default_: `nil`

    - `OffPlayerID`: Offensive player ID filter.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OffPlayerID: 201939`
      - _Default_: `nil`

    - `DefTeamID`: Defensive team ID filter.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `DefTeamID: 1610612747`
      - _Default_: `nil`

    - `DefPlayerID`: Defensive player ID filter.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `DefPlayerID: 201939`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueSeasonMatchups.get(LeagueID: "00", PerMode: "PerGame", Season: "2024-25", SeasonType: "Regular Season")
      {:ok, %{"LeagueSeasonMatchups" => [%{...}, ...]}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
