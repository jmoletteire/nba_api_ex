defmodule NBA.Stats.LeagueDashTeamShotLocations do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league dash team shot locations stats.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashteamshotlocations"

  @accepted_types %{
    Conference: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    DistanceRange: [:string],
    GameScope: [:string],
    GameSegment: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlusMinus: [:string],
    PORound: [:integer],
    Rank: [:string],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
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
    DistanceRange: "By Zone"
  ]

  @required [:Season]

  @doc """
  Fetches league dash team shot locations stats data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `DistanceRange`: The distance range for shots.
      - _Type(s)_: `String`
      - _Example_: `DistanceRange: "By Zone"`
      - _Default_: `"By Zone"`
      - _Valueset_:
        - "By Zone"
        - "Less Than 8 ft."
        - "8-16 ft."
        - "16-24 ft."
        - "24+ ft."
        - "Backcourt"

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

    - `MeasureType`: The type of measure to return.
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

    - `PlusMinus`: Whether to include plus/minus splits.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "Y"`
      - _Default_: `"Y"`
      - _Valueset_:
        - "Y"
        - "N"

    - `PaceAdjust`: Whether to adjust stats for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "Y"`
      - _Default_: `"Y"`
      - _Valueset_:
        - "Y"
        - "N"

    - `Rank`: Whether to include team rank.
      - _Type(s)_: `String`
      - _Example_: `Rank: "Y"`
      - _Default_: `"Y"`
      - _Valueset_:
        - "Y"
        - "N"

    - `LeagueID`: The league ID ("00" for NBA, "20" for G-League).
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - "00"
        - "20"

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - "Regular Season"
        - "Pre Season"
        - "Playoffs"
        - "All Star"

    - `PORound`: Playoff round (0 for regular season).
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 0`
      - _Default_: `0`

    - `Month`: Month filter (0 for all months).
      - _Type(s)_: `Integer`
      - _Example_: `Month: 0`
      - _Default_: `0`

    - `OpponentTeamID`: Opponent team ID (0 for all teams).
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OpponentTeamID: 0`
      - _Default_: `0`

    - `TeamID`: Team ID (0 for all teams).
      - _Type(s)_: `Integer` or `String`
      - _Example_: `TeamID: 0`
      - _Default_: `0`

    - `Period`: Period filter (0 for all periods).
      - _Type(s)_: `Integer`
      - _Example_: `Period: 0`
      - _Default_: `0`

    - `LastNGames`: Number of most recent games to include (0 for all).
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 0`
      - _Default_: `0`

    - `Conference`: Conference filter ("East", "West", or empty for all).
      - _Type(s)_: `String`
      - _Example_: `Conference: "East"`
      - _Default_: `""`
      - _Valueset_:
        - "East"
        - "West"
        - "" (all)

    - `Division`: Division filter (e.g., "Atlantic", "Central", "Northwest", etc.).
      - _Type(s)_: `String`
      - _Example_: `Division: "Atlantic"`
      - _Default_: `""`

    - `GameScope`: Game scope (e.g., "Season", "Last 10", "Yesterday").
      - _Type(s)_: `String`
      - _Example_: `GameScope: "Season"`
      - _Default_: `""`

    - `GameSegment`: Game segment ("First Half", "Second Half", "Overtime", or empty).
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `""`
      - _Valueset_:
        - "First Half"
        - "Second Half"
        - "Overtime"
        - "" (all)

    - `DateFrom`: Start date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "01/01/2024"`
      - _Default_: `""`

    - `DateTo`: End date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateTo: "01/31/2024"`
      - _Default_: `""`

    - `Location`: Game location ("Home", "Road", or empty for all).
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `""`
      - _Valueset_:
        - "Home"
        - "Road"
        - "" (all)

    - `Outcome`: Game outcome ("W", "L", or empty for all).
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `""`
      - _Valueset_:
        - "W"
        - "L"
        - "" (all)

    - `SeasonSegment`: Season segment ("Post All-Star", "Pre All-Star", or empty).
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All-Star"`
      - _Default_: `""`
      - _Valueset_:
        - "Post All-Star"
        - "Pre All-Star"
        - "" (all)

    - `StarterBench`: Filter by starters or bench ("Starters", "Bench", or empty).
      - _Type(s)_: `String`
      - _Example_: `StarterBench: "Starters"`
      - _Default_: `""`
      - _Valueset_:
        - "Starters"
        - "Bench"
        - "" (all)

    - `VsConference`: Opponent conference filter ("East", "West", or empty).
      - _Type(s)_: `String`
      - _Example_: `VsConference: "West"`
      - _Default_: `""`
      - _Valueset_:
        - "East"
        - "West"
        - "" (all)

    - `VsDivision`: Opponent division filter (e.g., "Atlantic", "Central", etc., or empty).
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Central"`
      - _Default_: `""`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashTeamShotLocations.get(Season: "2024-25")
      {:ok, %{"LeagueDashTeamShotLocations" => [%{...}, ...]}}
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
