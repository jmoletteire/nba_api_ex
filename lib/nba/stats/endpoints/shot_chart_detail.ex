defmodule NBA.Stats.ShotChartDetail do
  @moduledoc """
  Provides functions to interact with the NBA stats API for ShotChartDetail.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "shotchartdetail"

  @accepted_types %{
    ContextMeasure: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Period: [:integer],
    PlayerID: [:integer, :string],
    SeasonType: [:string],
    TeamID: [:integer, :string],
    VsDivision: [:string],
    VsConference: [:string],
    StartRange: [:integer, :string],
    StartPeriod: [:integer],
    SeasonSegment: [:string],
    Season: [:string],
    RookieYear: [:string],
    RangeType: [:integer, :string],
    Position: [:string],
    PointDiff: [:integer, :string],
    PlayerPosition: [:string],
    Outcome: [:string],
    Location: [:string],
    GameSegment: [:string],
    GameID: [:string],
    EndRange: [:integer, :string],
    EndPeriod: [:integer],
    DateTo: [:string],
    DateFrom: [:string],
    ContextFilter: [:string],
    ClutchTime: [:string],
    AheadBehind: [:string]
  }

  @default [
    ContextMeasure: "FGA",
    LastNGames: 0,
    LeagueID: "00",
    Month: 0,
    OpponentTeamID: 0,
    Period: 0,
    PlayerID: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    StartRange: nil,
    StartPeriod: nil,
    SeasonSegment: nil,
    Season: nil,
    RookieYear: nil,
    RangeType: nil,
    Position: nil,
    PointDiff: nil,
    PlayerPosition: nil,
    Outcome: nil,
    Location: nil,
    GameSegment: nil,
    GameID: nil,
    EndRange: nil,
    EndPeriod: nil,
    DateTo: nil,
    DateFrom: nil,
    ContextFilter: nil,
    ClutchTime: nil,
    AheadBehind: nil
  ]

  @required [
    :PlayerID,
    :Season
  ]

  @doc """
  Fetches ShotChartDetail data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `AheadBehind`: The ahead/behind context.
      - _Type(s)_: `String`
      - _Example_: `AheadBehind: "Ahead or Tied"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Ahead or Behind"`
        - `"Ahead or Tied"`
        - `"Behind or Tied"`

    - `ClutchTime`: The clutch time.
      - _Type(s)_: `String`
      - _Example_: `ClutchTime: "Last 5 Minutes"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Last 5 Minutes"`
        - `"Last 4 Minutes"`
        - `"Last 3 Minutes"`
        - `"Last 2 Minutes"`
        - `"Last 1 Minute"`
        - `"Last 30 Seconds"`
        - `"Last 10 Seconds"`

    - `ContextFilter`: The context filter.
      - _Type(s)_: `String`
      - _Example_: `ContextFilter: ""`
      - _Default_: `nil`

    - `ContextMeasure`: The context measure.
      - _Type(s)_: `String`
      - _Example_: `ContextMeasure: "FGA"`
      - _Default_: `"FGA"`
      - _Valueset_:
        - `"PTS"`
        - `"FGM"`
        - `"FGA"`
        - `"FG_PCT"`
        - `"FG3M"`
        - `"FG3A"`
        - `"FG3_PCT"`
        - `"PF"`
        - `"EFG_PCT"`
        - `"TS_PCT"`
        - `"PTS_FB"`
        - `"PTS_OFF_TOV"`
        - `"PTS_2ND_CHANCE"`

    - `DateFrom`: The start date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2025-01-01"`
      - _Default_: `nil`

    - `DateTo`: The end date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2025-03-01"`
      - _Default_: `nil`

    - `EndPeriod`: The end period.
      - _Type(s)_: `Integer`
      - _Example_: `EndPeriod: 4`
      - _Default_: `nil`

    - `EndRange`: The end range.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `EndRange: 28800`
      - _Default_: `nil`

    - `GameID`: The game ID. 10-digit string or nil.
      - _Type(s)_: `String`
      - _Example_: `GameID: "0022100001"`
      - _Default_: `nil`

    - `GameSegment`: The game segment.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Overtime"`
        - `"Second Half"`

    - `LastNGames`: Number of last games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 0`
      - _Default_: `0`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`

    - `Location`: The game location.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `Month`: The month (1-12, 0 for all).
      - _Type(s)_: `Integer`
      - _Example_: `Month: 0`
      - _Default_: `0`

    - `OpponentTeamID`: The opponent team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612737`
      - _Default_: `0`

    - `Outcome`: The game outcome.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `Period`: The period (0 for all).
      - _Type(s)_: `Integer`
      - _Example_: `Period: 0`
      - _Default_: `0`

    - `PlayerPosition`: The player position.
      - _Type(s)_: `String`
      - _Example_: `PlayerPosition: "Guard"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Guard"`
        - `"Center"`
        - `"Forward"`

    - `PointDiff`: The point differential.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PointDiff: 5`
      - _Default_: `nil`

    - `Position`: The position.
      - _Type(s)_: `String`
      - _Example_: `Position: "Guard"`
      - _Default_: `nil`

    - `RangeType`: The range type.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `RangeType: 2`
      - _Default_: `nil`

    - `RookieYear`: The rookie year.
      - _Type(s)_: `String`
      - _Example_: `RookieYear: "2019"`
      - _Default_: `nil`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Pre All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `StartPeriod`: The start period.
      - _Type(s)_: `Integer`
      - _Example_: `StartPeriod: 1`
      - _Default_: `nil`

    - `StartRange`: The start range.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `StartRange: 0`
      - _Default_: `nil`

    - `TeamID`: The team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612737`
      - _Default_: `nil`

    - `VsConference`: The opposing conference.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: The opposing division.
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
      iex> NBA.Stats.ShotChartDetail.get(ContextMeasure: "FGA", LastNGames: 0, LeagueID: "00", Month: 0, OpponentTeamID: 0, Period: 0, PlayerID: 201939, SeasonType: "Regular Season", TeamID: 1610612737)
      {:ok, %{"ShotChartDetail" => [%{...}, ...]}}
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
