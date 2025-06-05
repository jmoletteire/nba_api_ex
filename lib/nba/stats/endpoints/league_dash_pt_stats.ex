defmodule NBA.Stats.LeagueDashPtStats do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league player tracking shot stats.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashptstats"

  @accepted_types %{
    College: [:string],
    Conference: [:string],
    Country: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    DraftPick: [:string],
    DraftYear: [:string],
    DribbleRange: [:string],
    GameSegment: [:string],
    Height: [:string],
    ISTRound: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlayerExperience: [:string],
    PlayerID: [:integer, :string],
    PlayerPosition: [:string],
    PORound: [:integer],
    PtMeasureType: [:string],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    ShotClockRange: [:string],
    StarterBench: [:string],
    TeamID: [:integer, :string],
    TouchTimeRange: [:string],
    VsConference: [:string],
    VsDivision: [:string],
    Weight: [:string]
  }

  @default [
    PerMode: "PerGame",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PtMeasureType: "SpeedDistance",
    PORound: 0,
    PlayerID: nil,
    TeamID: 0,
    Outcome: nil,
    Location: nil,
    Month: 0,
    SeasonSegment: nil,
    DateFrom: nil,
    DateTo: nil,
    OpponentTeamID: 0,
    VsConference: nil,
    VsDivision: nil,
    Conference: nil,
    Division: nil,
    GameSegment: nil,
    Period: 0,
    LastNGames: 0,
    DraftYear: nil,
    DraftPick: nil,
    College: nil,
    Country: nil,
    Height: nil,
    Weight: nil,
    PlayerExperience: nil,
    PlayerPosition: nil,
    StarterBench: nil,
    DribbleRange: nil,
    ShotClockRange: nil,
    TouchTimeRange: nil,
    ISTRound: nil
  ]

  @required [:Season]

  @doc """
  Fetches league player tracking data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `College`: The college of the player.
      - _Type(s)_: `String`
      - _Example_: `College: "Duke"`
      - _Default_: `nil`

    - `Conference`: The conference of the team.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

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
        - `"Atlantic"`
        - `"Central"`
        - `"Southeast"`
        - `"Northwest"`
        - `"Pacific"`
        - `"Southwest"`

    - `DraftPick`: The draft pick of the player.
      - _Type(s)_: `String`
      - _Example_: `DraftPick: "1"`
      - _Default_: `nil`

    - `DraftYear`: The draft year of the player.
      - _Type(s)_: `String`
      - _Example_: `DraftYear: "2018"`
      - _Default_: `nil`

    - `DribbleRange`: The dribble range for filtering.
      - _Type(s)_: `String`
      - _Example_: `DribbleRange: "0 Dribbles"`
      - _Default_: `nil`
      - _Valueset_:
        - `"0 Dribbles"`
        - `"1 Dribble"`
        - `"2 Dribbles"`
        - `"3-6 Dribbles"`
        - `"7+ Dribbles"`

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Second Half"`
        - `"Overtime"`

    - `Height`: The height of the player.
      - _Type(s)_: `String`
      - _Example_: `Height: "6-7"`
      - _Default_: `nil`

    - `ISTRound`: The round of the In-Season Tournament.
      - _Type(s)_: `String`
      - _Example_: `ISTRound: "All IST"`
      - _Default_: `nil`

    - `LastNGames`: The number of last games to consider.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 5`
      - _Default_: `0`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"`
        - `"10"`
        - `"20"`

    - `Location`: The location of the game.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Away"`

    - `Month`: The month of the season.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `0`

    - `OpponentTeamID`: The ID of the opponent team.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OpponentTeamID: 1610612739`
      - _Default_: `0`

    - `Outcome`: The outcome of the game.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
        - `"Per48"`
        - `"Per40"`
        - `"Per36"`
        - `"PerMinute"`
        - `"PerPossession"`
        - `"PerPlay"`
        - `"Per100Possessions"`
        - `"Per100Plays"`

    - `Period`: The period of the game.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1`
      - _Default_: `0`

    - `PlayerExperience`: The experience level of the player.
      - _Type(s)_: `String`
      - _Example_: `PlayerExperience: "Rookie"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Rookie"`
        - `"Sophomore"`
        - `"Veteran"`

    - `PlayerID`: The NBA player ID (use `nil` for league-wide).
      - _Type(s)_: `Integer` or `String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `PlayerPosition`: The position of the player.
      - _Type(s)_: `String`
      - _Example_: `PlayerPosition: "F"`
      - _Default_: `nil`
      - _Valueset_:
        - `"F"`
        - `"C"`
        - `"G"`

    - `PtMeasureType`: The type of player tracking measure.
    - _Type(s)_: `String`
      - _Example_: `PtMeasureType: "SpeedDistance"`
      - _Default_: `"SpeedDistance"`
      - _Valueset_:
        - `"SpeedDistance"`
        - `"Rebounding"`
        - `"Possessions"`
        - `"CatchShoot"`
        - `"PullUpShot"`
        - `"Defense"`
        - `"Drives"`
        - `"Passing"`
        - `"ElbowTouch"`
        - `"PostTouch"`
        - `"PaintTouch"`
        - `"Efficiency"`

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1`
      - _Default_: `0`

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Pre All Star"`
        - `"Post All Star"`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Playoffs"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Playoffs"`
        - `"Pre Season"`
        - `"All Star"`
        - `"Play In"`

    - `ShotClockRange`: The range of the shot clock.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "24+"`
      - _Default_: `nil`
      - _Valueset_:
        - `"24+"`
        - `"22-18"`
        - `"15-7"`
        - `"4-0"`
        - `"NA"`

    - `StarterBench`: Whether the player is a starter or bench.
      - _Type(s)_: `String`
      - _Example_: `StarterBench: "Bench"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Starter"`
        - `"Bench"`

    - `TeamID`: The ID of the team.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `TeamID: 1610612756`
      - _Default_: `0`

    - `TouchTimeRange`: The touch time range for filtering.
      - _Type(s)_: `String`
      - _Example_: `TouchTimeRange: "Touch < 2 Seconds"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Touch < 2 Seconds"`
        - `"Touch 2-6 Seconds"`
        - `"Touch 6+ Seconds"`

    - `VsConference`: The conference of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: The division of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Central"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Atlantic"`
        - `"Central"`
        - `"Southeast"`
        - `"Northwest"`
        - `"Pacific"`
        - `"Southwest"`

    - `Weight`: The weight of the player.
      - _Type(s)_: `String`
      - _Example_: `Weight: "220"`
      - _Default_: `nil`

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashPtStats.get(Season: "2024-25")
      {:ok, %{"LeagueDashPtStats" => [%{...}, ...]}}
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
