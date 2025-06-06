defmodule NBA.Stats.TeamGameLogs do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamGameLogs.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamgamelogs"

  @accepted_types %{
    DateFrom: [:string],
    DateTo: [:string],
    GameSegment: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    MeasureType: [:string],
    Month: [:integer],
    OppTeamID: [:integer],
    Outcome: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlayerID: [:integer],
    PORound: [:integer],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    ShotClockRange: [:string],
    TeamID: [:integer],
    VsConference: [:string],
    VsDivision: [:string]
  }

  @default [
    DateFrom: nil,
    DateTo: nil,
    GameSegment: nil,
    LastNGames: nil,
    LeagueID: "00",
    Location: nil,
    MeasureType: nil,
    Month: nil,
    OppTeamID: nil,
    Outcome: nil,
    PerMode: nil,
    Period: nil,
    PlayerID: nil,
    PORound: nil,
    Season: nil,
    SeasonSegment: nil,
    SeasonType: nil,
    ShotClockRange: nil,
    TeamID: nil,
    VsConference: nil,
    VsDivision: nil
  ]

  @required [:TeamID]

  @doc """
  Fetches TeamGameLogs data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data. All parameters are optional and default to `nil` unless otherwise noted.

    - `DateFrom`: The start date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `DateTo`: The end date (YYYY-MM-DD).
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

    - `MeasureType`: The measure type.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Base"`
        - `"Advanced"`
        - `"Misc"`
        - `"Four Factors"`
        - `"Scoring"`
        - `"Opponent"`
        - `"Usage"`
        - `"Defense"`

    - `Month`: The month (1-12).
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `OppTeamID`: The opponent team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Outcome`: The game outcome.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PerMode`: The per mode.
      - _Type(s)_: `String`
      - _Default_: `nil`
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

    - `Period`: The period.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `PlayerID`: The player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Season`: The season.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Default_: `nil`
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

    - `TeamID`: The team ID.
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
      iex> NBA.Stats.TeamGameLogs.get(Season: "2024-25", TeamID: 1610612744)
      {:ok, %{"TeamGameLogs" => [%{...}, ...]}}
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
