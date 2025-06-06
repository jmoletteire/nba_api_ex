defmodule NBA.Stats.TeamDashLineups do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamDashLineups.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamdashlineups"

  @accepted_types %{
    GroupQuantity: [:integer],
    LastNGames: [:integer],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer],
    VsDivision: [:string],
    VsConference: [:string],
    ShotClockRange: [:string],
    SeasonSegment: [:string],
    PORound: [:integer],
    Outcome: [:string],
    Location: [:string],
    LeagueID: [:string],
    GameSegment: [:string],
    GameID: [:string],
    DateTo: [:string],
    DateFrom: [:string]
  }

  @default [
    GroupQuantity: 5,
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "N",
    Rank: "N",
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    ShotClockRange: nil,
    SeasonSegment: nil,
    PORound: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: "00",
    GameSegment: nil,
    GameID: nil,
    DateTo: nil,
    DateFrom: nil
  ]

  # Only parameters with no default value should be required
  @required [:GroupQuantity, :Season, :TeamID]

  @doc """
  Fetches TeamDashLineups data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `GroupQuantity`: **(Required)** The number of players in the lineup group.
      - _Type(s)_: `Integer`
      - _Default_: `5`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `DateFrom`: The start date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`
    - `DateTo`: The end date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`
    - `GameID`: The game ID. 10-digit string or nil.
      - _Type(s)_: `String`
      - _Default_: `nil`
    - `GameSegment`: The game segment.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Overtime"`
        - `"Second Half"`
    - `LastNGames`: Number of last games to include.
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"`
    - `Location`: The game location.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`
    - `MeasureType`: The measure type.
      - _Type(s)_: `String`
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
    - `Month`: The month (1-12, 0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `OpponentTeamID`: The opponent team ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `Outcome`: The game outcome.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`
    - `PaceAdjust`: Whether to adjust for pace.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`
    - `PerMode`: The per mode.
      - _Type(s)_: `String`
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
    - `Period`: The period (0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `PlusMinus`: Whether to include plus/minus.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`
    - `PORound`: The playoff round (if applicable, else nil).
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `Rank`: Whether to include rank.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`
    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`
    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`
    - `ShotClockRange`: The shot clock range.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"24-22"`
        - `"22-18 Very Early"`
        - `"18-15 Early"`
        - `"15-7 Average"`
        - `"7-4 Late"`
        - `"4-0 Very Late"`
        - `"ShotClock Off"`
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
      iex> NBA.Stats.TeamDashLineups.get(GroupQuantity: 5, LastNGames: 0, MeasureType: "Base", Month: 0, OpponentTeamID: 1610612737, PaceAdjust: "N", PerMode: "PerGame", Period: 0, PlusMinus: "N", Rank: "N", Season: "2024-25", SeasonType: "Regular Season", TeamID: 1610612744)
      {:ok, %{"TeamDashLineups" => [%{...}, ...]}}
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
