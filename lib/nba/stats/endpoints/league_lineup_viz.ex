defmodule NBA.Stats.LeagueLineupViz do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league lineup viz.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguelineupviz"

  @accepted_types %{
    Conference: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    GameSegment: [:string],
    GroupQuantity: [:integer],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    MeasureType: [:string],
    MinutesMin: [:integer],
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
    ShotClockRange: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string]
  }

  @default [
    GroupQuantity: 5,
    LastNGames: 0,
    MeasureType: "Base",
    MinutesMin: 0,
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "Y",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "Y",
    Rank: "Y",
    Season: nil,
    SeasonType: "Regular Season",
    VsDivision: nil,
    VsConference: nil,
    TeamID: nil,
    ShotClockRange: nil,
    SeasonSegment: nil,
    PORound: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: nil,
    GameSegment: nil,
    Division: nil,
    DateTo: nil,
    DateFrom: nil,
    Conference: nil
  ]

  @required [:Season]

  @doc """
  Fetches league lineup viz data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `Conference`: Conference filter (e.g., "East", "West").
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `DateFrom`: Start date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "01/01/2024"`
      - _Default_: `nil`

    - `DateTo`: End date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateTo: "01/31/2024"`
      - _Default_: `nil`

    - `Division`: Division filter (e.g., "Atlantic", "Central", etc.).
      - _Type(s)_: `String`
      - _Example_: `Division: "Pacific"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Atlantic"`
        - `"Central"`
        - `"Northwest"`
        - `"Pacific"`
        - `"Southeast"`
        - `"Southwest"`

    - `GameSegment`: Game segment filter (e.g., "First Half", "Second Half", "Overtime").
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Second Half"`
        - `"Overtime"`

    - `GroupQuantity`: Number of players in the lineup.
      - _Type(s)_: `Integer`
      - _Example_: `GroupQuantity: 5`
      - _Default_: `5`

    - `LastNGames`: Number of most recent games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 0`
      - _Default_: `0`

    - `LeagueID`: League ID filter.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `nil`

    - `Location`: Game location filter ("Home", "Road").
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `MeasureType`: The type of measure to return.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `"Base"`
      - _Valueset_:
        - `"Base"`
        - `"Advanced"`
        - `"Misc"`
        - `"Four Factors"`
        - `"Scoring"`
        - `"Opponent"`
        - `"Usage"`
        - `"Defense"`

    - `MinutesMin`: Minimum minutes played.
      - _Type(s)_: `Integer`
      - _Example_: `MinutesMin: 0`
      - _Default_: `0`

    - `Month`: Month filter.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 0`
      - _Default_: `0`

    - `OpponentTeamID`: Opponent team ID filter.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 0`
      - _Default_: `0`

    - `Outcome`: Game outcome filter ("W", "L").
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PaceAdjust`: Whether to adjust stats for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
        - `"MinutesPer"`
        - `"Per48"`
        - `"Per40"`
        - `"Per36"`
        - `"PerMinute"`
        - `"PerPossession"`
        - `"PerPlay"`
        - `"Per100Possessions"`
        - `"Per100Plays"`

    - `Period`: Period filter.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 0`
      - _Default_: `0`

    - `PlusMinus`: Whether to include plus/minus splits.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `PORound`: Playoff round filter.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 0`
      - _Default_: `nil`

    - `Rank`: Whether to include team rank.
      - _Type(s)_: `String`
      - _Example_: `Rank: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `SeasonSegment`: Season segment filter ("Post All-Star", "Pre All-Star").
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

    - `ShotClockRange`: Shot clock range filter.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "24-22"`
      - _Default_: `nil`
      - _Valueset_:
        - `"24-22"`
        - `"22-18 Very Early"`
        - `"18-15 Early"`
        - `"15-7 Average"`
        - `"7-4 Late"`
        - `"4-0 Very Late"`
        - `"ShotClock Off"`

    - `TeamID`: Team ID filter.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `nil`

    - `VsConference`: Opponent conference filter ("East", "West").
      - _Type(s)_: `String`
      - _Example_: `VsConference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: Opponent division filter (e.g., "Atlantic", "Central", etc.).
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Pacific"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Atlantic"`
        - `"Central"`
        - `"Northwest"`
        - `"Pacific"`
        - `"Southeast"`
        - `"Southwest"`
        - `"East"`
        - `"West"`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueLineupViz.get(Season: "2024-25", GroupQuantity: 5, PerMode: "PerGame", SeasonType: "Regular Season")
      {:ok, %{"LeagueLineupViz" => [%{...}, ...]}}
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
