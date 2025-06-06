defmodule NBA.Stats.VideoDetailsAsset do
  @moduledoc """
  Provides functions to interact with the NBA stats API for VideoDetailsAsset.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "videodetailsasset"

  @accepted_types %{
    ContextMeasure: [:string],
    LastNGames: [:integer],
    Month: [:integer],
    OpponentTeamID: [:integer],
    Period: [:integer],
    PlayerID: [:integer],
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer],
    AheadBehind: [:string],
    ClutchTime: [:string],
    ContextFilter: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    EndPeriod: [:integer],
    EndRange: [:integer],
    GameID: [:string],
    GameSegment: [:string],
    LeagueID: [:string],
    Location: [:string],
    Outcome: [:string],
    PointDiff: [:integer],
    Position: [:string],
    RangeType: [:integer],
    RookieYear: [:string],
    SeasonSegment: [:string],
    StartPeriod: [:integer],
    StartRange: [:integer],
    VsConference: [:string],
    VsDivision: [:string]
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
    AheadBehind: nil,
    ClutchTime: nil,
    ContextFilter: nil,
    DateFrom: nil,
    DateTo: nil,
    EndPeriod: nil,
    EndRange: nil,
    GameID: nil,
    GameSegment: nil,
    LeagueID: "00",
    Location: nil,
    Outcome: nil,
    PointDiff: nil,
    Position: nil,
    RangeType: nil,
    RookieYear: nil,
    SeasonSegment: nil,
    StartPeriod: nil,
    StartRange: nil,
    VsConference: nil,
    VsDivision: nil
  ]

  @required [
    :ContextMeasure,
    :LastNGames,
    :Month,
    :OpponentTeamID,
    :Period,
    :PlayerID,
    :Season,
    :SeasonType,
    :TeamID
  ]

  @doc """
  Fetches VideoDetailsAsset data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `ContextMeasure`: **(Required)** The context measure.
      - _Type(s)_: `String`
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

    - `LastNGames`: **(Required)** Number of last games to include.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `Month`: **(Required)** The month (1-12, 0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `OpponentTeamID`: **(Required)** The opponent team ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `Period`: **(Required)** The period (0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `SeasonType`: **(Required)** The season type.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `AheadBehind`: The ahead/behind context.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `ClutchTime`: The clutch time.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `ContextFilter`: The context filter.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `DateFrom`: The start date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `DateTo`: The end date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `EndPeriod`: The end period.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `EndRange`: The end range.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `GameID`: The game ID. 10-digit string or nil.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `GameSegment`: The game segment.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"`

    - `Location`: The game location.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `Outcome`: The game outcome.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PointDiff`: The point differential.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Position`: The position.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `RangeType`: The range type.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `RookieYear`: The rookie year.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `StartPeriod`: The start period.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `StartRange`: The start range.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `VsConference`: The opposing conference.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: The opposing division.
      - _Type(s)_: `String`
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
      iex> NBA.Stats.VideoDetailsAsset.get(PlayerID: 201939, Season: "2024-25", ContextMeasure: "FGM", LastNGames: 0, Month: 0, OpponentTeamID: 1610612737, Period: 0, SeasonType: "Regular Season", TeamID: 1610612744)
      {:ok, %{"VideoDetailsAsset" => [%{...}, ...]}}
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
