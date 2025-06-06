defmodule NBA.Stats.VideoDetails do
  @moduledoc """
  Provides functions to interact with the NBA stats API for VideoDetails.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "videodetails"

  @accepted_types %{
    ContextMeasure: [:string],
    LastNGames: [:integer],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Period: [:integer],
    PlayerID: [:integer, :string],
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer, :string],
    VsDivision: [:string],
    VsConference: [:string],
    StartRange: [:integer, :string],
    StartPeriod: [:integer],
    SeasonSegment: [:string],
    RookieYear: [:string],
    RangeType: [:integer, :string],
    Position: [:string],
    PointDiff: [:integer, :string],
    Outcome: [:string],
    Location: [:string],
    LeagueID: [:string],
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
    ContextMeasure: "FGM",
    LastNGames: 0,
    Month: 0,
    OpponentTeamID: 0,
    Period: 0,
    PlayerID: nil,
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    StartRange: nil,
    StartPeriod: nil,
    SeasonSegment: nil,
    RookieYear: nil,
    RangeType: nil,
    Position: nil,
    PointDiff: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: "00",
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
  Fetches VideoDetails data.

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

    - `ClutchTime`: The clutch time.
      - _Type(s)_: `String`
      - _Example_: `ClutchTime: "Last 5 Minutes"`
      - _Default_: `nil`

    - `ContextFilter`: The context filter.
      - _Type(s)_: `String`
      - _Example_: `ContextFilter: ""`
      - _Default_: `nil`

    - `ContextMeasure`: The context measure.
      - _Type(s)_: `String`
      - _Example_: `ContextMeasure: "FGM"`
      - _Default_: `"FGM"`
      - _Valueset_:
        - `"FGM"`
        - `"FGA"`
        - `"FG_PCT"`
        - `"FG3M"`
        - `"FG3A"`
        - `"FG3_PCT"`
        - `"FTM"`
        - `"FTA"`
        - `"OREB"`
        - `"DREB"`
        - `"AST"`
        - `"FGM_AST"`
        - `"FG3_AST"`
        - `"STL"`
        - `"BLK"`
        - `"BLKA"`
        - `"TOV"`
        - `"PF"`
        - `"PFD"`
        - `"POSS_END_FT"`
        - `"PTS_PAINT"`
        - `"PTS_FB"`
        - `"PTS_OFF_TOV"`
        - `"PTS_2ND_CHANCE"`
        - `"REB"`
        - `"TM_FGM"`
        - `"TM_FGA"`
        - `"TM_FG3M"`
        - `"TM_FG3A"`
        - `"TM_FTM"`
        - `"TM_FTA"`
        - `"TM_OREB"`
        - `"TM_DREB"`
        - `"TM_REB"`
        - `"TM_TEAM_REB"`
        - `"TM_AST"`
        - `"TM_STL"`
        - `"TM_BLK"`
        - `"TM_BLKA"`
        - `"TM_TOV"`
        - `"TM_TEAM_TOV"`
        - `"TM_PF"`
        - `"TM_PFD"`
        - `"TM_PTS"`
        - `"TM_PTS_PAINT"`
        - `"TM_PTS_FB"`
        - `"TM_PTS_OFF_TOV"`
        - `"TM_PTS_2ND_CHANCE"`
        - `"TM_FGM_AST"`
        - `"TM_FG3_AST"`
        - `"TM_POSS_END_FT"`
        - `"OPP_FGM"`
        - `"OPP_FGA"`
        - `"OPP_FG3M"`
        - `"OPP_FG3A"`
        - `"OPP_FTM"`
        - `"OPP_FTA"`
        - `"OPP_OREB"`
        - `"OPP_DREB"`
        - `"OPP_REB"`
        - `"OPP_TEAM_REB"`
        - `"OPP_AST"`
        - `"OPP_STL"`
        - `"OPP_BLK"`
        - `"OPP_BLKA"`
        - `"OPP_TOV"`
        - `"OPP_TEAM_TOV"`
        - `"OPP_PF"`
        - `"OPP_PFD"`
        - `"OPP_PTS"`
        - `"OPP_PTS_PAINT"`
        - `"OPP_PTS_FB"`
        - `"OPP_PTS_OFF_TOV"`
        - `"OPP_PTS_2ND_CHANCE"`
        - `"OPP_FGM_AST"`
        - `"OPP_FG3_AST"`
        - `"OPP_POSS_END_FT"`
        - `"PTS"`

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

    - `Period`: The period (0 for all).
      - _Type(s)_: `Integer`
      - _Example_: `Period: 0`
      - _Default_: `0`

    - `PlayerPosition`: The player position.
      - _Type(s)_: `String`
      - _Example_: `PlayerPosition: "Guard"`
      - _Default_: `nil`

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

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`

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

    - `VsDivision`: The opposing division.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Pacific"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.VideoDetails.get(PlayerID: 201939, Season: "2024-25")
      {:ok, %{"VideoDetails" => [%{...}, ...]}}
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
