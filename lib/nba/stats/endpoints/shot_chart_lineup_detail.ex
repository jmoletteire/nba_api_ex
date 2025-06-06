defmodule NBA.Stats.ShotChartLineupDetail do
  @moduledoc """
  Provides functions to interact with the NBA stats API for ShotChartLineupDetail.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "shotchartlineupdetail"

  @accepted_types %{
    ContextMeasure: [:string],
    GROUP_ID: [:string],
    LeagueID: [:string],
    Period: [:integer],
    Season: [:string],
    SeasonType: [:string],
    VsDivision: [:string],
    VsConference: [:string],
    TeamID: [:integer, :string],
    SeasonSegment: [:string],
    Outcome: [:string],
    OpponentTeamID: [:integer, :string],
    Month: [:integer],
    Location: [:string],
    LastNGames: [:integer],
    GameSegment: [:string],
    GameID: [:string],
    DateTo: [:string],
    DateFrom: [:string],
    ContextFilter: [:string]
  }

  @default [
    ContextMeasure: "PTS",
    GROUP_ID: nil,
    LeagueID: "00",
    Period: 0,
    Season: nil,
    SeasonType: "Regular Season",
    VsDivision: nil,
    VsConference: nil,
    TeamID: 0,
    SeasonSegment: nil,
    Outcome: nil,
    OpponentTeamID: 0,
    Month: 0,
    Location: nil,
    LastNGames: 0,
    GameSegment: nil,
    GameID: nil,
    DateTo: nil,
    DateFrom: nil,
    ContextFilter: nil
  ]

  @required [
    :GROUP_ID,
    :Season
  ]

  @doc """
  Fetches ShotChartLineupDetail data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `ContextMeasure`: **(Required)** The context measure.
      - _Type(s)_: `String`
      - _Example_: `ContextMeasure: "PTS"`
      - _Default_: `"PTS"`
      - _Valueset_:
        - `"PTS"`
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

    - `GROUP_ID`: **(Required)** The lineup group ID.
      - _Type(s)_: `String`
      - _Example_: `GROUP_ID: "1610612737 - 201939 - 202691 - 203507 - 203954"`
      - _Default_: `nil`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `ContextFilter`: The context filter.
      - _Type(s)_: `String`
      - _Example_: `ContextFilter: ""`
      - _Default_: `nil`

    - `DateFrom`: The start date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2025-01-01"`
      - _Default_: `nil`

    - `DateTo`: The end date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2025-03-01"`
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

    - `LastNGames`: The number of last games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 0`
      - _Default_: `nil`

    - `LeagueID`: The league ID. Defaults to `"00"` (NBA). Not required.
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
      - _Default_: `nil`

    - `OpponentTeamID`: The opponent team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612737`
      - _Default_: `nil`

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

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Pre All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

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
      iex> NBA.Stats.ShotChartLineupDetail.get(ContextMeasure: "PTS", GROUP_ID: "1610612737 - 201939 - 202691 - 203507 - 203954", Season: "2024-25")
      {:ok, %{"ShotChartLineupDetail" => [%{...}, ...]}}
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
