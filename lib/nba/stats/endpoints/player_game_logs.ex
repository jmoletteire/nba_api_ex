defmodule NBA.Stats.PlayerGameLogs do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerGameLogs.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playergamelogs"

  @accepted_types %{
    VsDivision: [:string],
    VsConference: [:string],
    TeamID: [:integer, :string],
    ShotClockRange: [:string],
    SeasonType: [:string],
    SeasonSegment: [:string],
    SeasonYear: [:string],
    PlayerID: [:integer, :string],
    Period: [:integer],
    PerMode: [:string],
    PORound: [:integer, :string],
    Outcome: [:string],
    OpposingTeamID: [:integer, :string],
    Month: [:integer],
    MeasureType: [:string],
    Location: [:string],
    LeagueID: [:string],
    LastNGames: [:integer],
    GameSegment: [:string],
    DateTo: [:string],
    DateFrom: [:string]
  }

  @default [
    VsDivision: nil,
    VsConference: nil,
    TeamID: nil,
    ShotClockRange: nil,
    SeasonType: "Regular Season",
    SeasonSegment: nil,
    SeasonYear: nil,
    PlayerID: nil,
    Period: 0,
    PerMode: "Totals",
    PORound: 0,
    Outcome: nil,
    OpposingTeamID: 0,
    Month: 0,
    MeasureType: "Base",
    Location: nil,
    LeagueID: "00",
    LastNGames: 0,
    GameSegment: nil,
    DateTo: nil,
    DateFrom: nil
  ]

  @required [:PlayerID, :SeasonYear]

  @doc """
  Fetches PlayerGameLogs data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer | String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `SeasonYear`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `SeasonYear: "2024-25"`
      - _Default_: `nil`

    - `VsDivision`: The vs division.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Atlantic"`
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

    - `VsConference`: The vs conference.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `TeamID`: The team ID.
      - _Type(s)_: `Integer | String`
      - _Example_: `TeamID: 1610612737`
      - _Default_: `nil`

    - `ShotClockRange`: The shot clock range.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "24-22"`
      - _Default_: `nil`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All-Star"`
        - `"All Star"`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Pre All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `Period`: The period number.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1`
      - _Default_: `nil`

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer | String`
      - _Example_: `PORound: 1`
      - _Default_: `nil`

    - `Outcome`: The outcome.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `OpposingTeamID`: The opposing team ID.
      - _Type(s)_: `Integer | String`
      - _Example_: `OpposingTeamID: 1610612738`
      - _Default_: `nil`

    - `Month`: The month number.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `nil`

    - `MeasureType`: The measure type.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `nil`

    - `Location`: The location.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

    - `LastNGames`: Number of last games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 10`
      - _Default_: `nil`

    - `GameSegment`: The game segment.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Overtime"`
        - `"Second Half"`

    - `DateTo`: The end date.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2024-01-31"`
      - _Default_: `nil`

    - `DateFrom`: The start date.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2024-01-01"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerGameLogs.get(PlayerID: 201939, Season: "2024-25")
      {:ok, %{"PlayerGameLogs" => [%{...}, ...]}}
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
