defmodule NBA.Stats.LeagueDashTeamClutch do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league dash team clutch stats.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashteamclutch"

  @accepted_types %{
    AheadBehind: [:string],
    ClutchTime: [:string],
    College: [:string],
    Conference: [:string],
    Country: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    GameScope: [:string],
    GameSegment: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PORound: [:integer],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlusMinus: [:string],
    PointDiff: [:integer],
    Rank: [:string],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    ShotClockRange: [:string],
    StarterBench: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string]
  }

  @default [
    MeasureType: "Base",
    PerMode: "PerGame",
    PlusMinus: "Y",
    PaceAdjust: "Y",
    Rank: "Y",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
    Month: 0,
    OpponentTeamID: 0,
    TeamID: 0,
    Period: 0,
    LastNGames: 0,
    ClutchTime: "Last 5 Minutes",
    AheadBehind: "Ahead or Behind",
    PointDiff: 5
  ]

  @required [:Season]

  @doc """
  Fetches league dash team clutch stats data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `ClutchTime`: The clutch time window.
      - _Type(s)_: `String`
      - _Example_: `ClutchTime: "Last 5 Minutes"`
      - _Default_: `"Last 5 Minutes"`
      - _Valueset_:
        - "Last 5 Minutes"
        - "Last 4 Minutes"
        - "Last 3 Minutes"
        - "Last 2 Minutes"
        - "Last 1 Minute"
        - "Last 30 Seconds"
        - "Last 10 Seconds"

    - `AheadBehind`: The score situation.
      - _Type(s)_: `String`
      - _Example_: `AheadBehind: "Ahead or Behind"`
      - _Default_: `"Ahead or Behind"`
      - _Valueset_:
        - "Ahead or Behind"
        - "Ahead or Tied"
        - "Behind or Tied"
        - "Ahead"
        - "Behind"
        - "Tied"

    - `PointDiff`: The point differential for clutch.
      - _Type(s)_: `Integer`
      - _Example_: `PointDiff: 5`
      - _Default_: `5`

    - `MeasureType`: The type of measure.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `"Base"`
      - _Valueset_:
        - "Base"
        - "Advanced"
        - "Misc"
        - "Four Factors"
        - "Scoring"
        - "Opponent"
        - "Usage"

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - "Totals"
        - "PerGame"
        - "Per48"
        - "Per40"
        - "Per36"
        - "PerMinute"
        - "PerPossession"
        - "PerPlay"
        - "Per100Possessions"
        - "Per100Plays"

    - `PlusMinus`: Whether to include plus/minus stats.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "Y"`
      - _Default_: `"Y"`
      - _Valueset_:
        - "Y"
        - "N"

    - `PaceAdjust`: Whether to adjust for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "Y"`
      - _Default_: `"Y"`
      - _Valueset_:
        - "Y"
        - "N"

    - `Rank`: Whether to include rank.
      - _Type(s)_: `String`
      - _Example_: `Rank: "Y"`
      - _Default_: `"Y"`
      - _Valueset_:
        - "Y"
        - "N"

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - "00"
        - "10"
        - "20"

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Playoffs"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - "Regular Season"
        - "Playoffs"
        - "Pre Season"
        - "All Star"
        - "Play In"

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1`
      - _Default_: `0`

    - `Month`: The month of the season.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `0`

    - `OpponentTeamID`: The ID of the opponent team.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612739`
      - _Default_: `0`

    - `TeamID`: The ID of the team.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `0`

    - `Period`: The period of the game.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1`
      - _Default_: `0`

    - `LastNGames`: The number of last games to consider.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 5`
      - _Default_: `0`

    - `College`: The college of the player.
      - _Type(s)_: `String`
      - _Example_: `College: "Duke"`
      - _Default_: `nil`

    - `Conference`: The conference of the team.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - "East"
        - "West"

    - `Country`: The country of the player.
      - _Type(s)_: `String`
      - _Example_: `Country: "USA"`
      - _Default_: `nil`

    - `DateFrom`: The start date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2023-10-01"`
      - _Default_: `nil`

    - `DateTo`: The end date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2024-04-15"`
      - _Default_: `nil`

    - `Division`: The division of the team.
      - _Type(s)_: `String`
      - _Example_: `Division: "Pacific"`
      - _Default_: `nil`
      - _Valueset_:
        - "Atlantic"
        - "Central"
        - "Southeast"
        - "Northwest"
        - "Pacific"
        - "Southwest"

    - `GameScope`: The scope of games.
      - _Type(s)_: `String`
      - _Example_: `GameScope: "Last 10"`
      - _Default_: `nil`

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - "First Half"
        - "Second Half"
        - "Overtime"

    - `Outcome`: The outcome of the game.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - "W"
        - "L"

    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All Star"`
      - _Default_: `nil`
      - _Valueset_:
        - "Pre All Star"
        - "Post All Star"

    - `ShotClockRange`: The range of the shot clock.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "24+"`
      - _Default_: `nil`
      - _Valueset_:
        - "24+"
        - "22-18"
        - "15-7"
        - "4-0"
        - "NA"

    - `StarterBench`: Whether the player is a starter or bench.
      - _Type(s)_: `String`
      - _Example_: `StarterBench: "Bench"`
      - _Default_: `nil`
      - _Valueset_:
        - "Starter"
        - "Bench"

    - `VsConference`: The conference of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"`
      - _Default_: `nil`
      - _Valueset_:
        - "East"
        - "West"

    - `VsDivision`: The division of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Central"`
      - _Default_: `nil`
      - _Valueset_:
        - "Atlantic"
        - "Central"
        - "Southeast"
        - "Northwest"
        - "Pacific"
        - "Southwest"

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashTeamClutch.get(Season: "2024-25")
      {:ok, %{"LeagueDashTeamClutch" => [%{...}, ...]}}
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
