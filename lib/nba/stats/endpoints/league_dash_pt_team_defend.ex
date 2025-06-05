defmodule NBA.Stats.LeagueDashPtTeamDefend do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league player tracking team defensive stats.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashptteamdefend"

  @accepted_types %{
    Conference: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    DefenseCategory: [:string],
    Division: [:string],
    GameSegment: [:string],
    ISTRound: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PerMode: [:string],
    Period: [:integer],
    PORound: [:integer],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    StarterBench: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string]
  }

  @default [
    PerMode: "PerGame",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
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
    StarterBench: nil,
    DefenseCategory: "Overall",
    ISTRound: nil
  ]

  @required [:Season, :DefenseCategory]

  @doc """
  Fetches league player tracking team defend stats data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `DefenseCategory`: **(Required)** The defensive category.
      - _Type(s)_: `String`
      - _Example_: `DefenseCategory: "Overall"`
      - _Default_: `"Overall"`
      - _Valueset_:
        - `"Overall"`
        - `"3 Pointers"`
        - `"2 Pointers"`
        - `"Less Than 6Ft"`
        - `"Less Than 10Ft"`
        - `"Greater Than 15Ft"`

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `Conference`: The conference of the team.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

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

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Second Half"`
        - `"Overtime"`

    - `ISTRound`: The round of the IST.
      - _Type(s)_: `String`
      - _Example_: `ISTRound: "All IST"` (all IST rounds)
      - _Default_: `nil` (no specific round)
      - _Valueset_:
        - `"All IST"` (All IST rounds)
        - `"Group Play"` (Group stage)
        - `"Knockout - All"` (Knockout stage)
        - `"Knockout Round - Quarter"` (Quarterfinals of the knockout stage)
        - `"Knockout Round - Semi"` (Semifinals of the knockout stage)
        - `"Knockout Round - Championship"` (Finals of the knockout stage)
        - `"Group Play - East Group A"` (Group A of the Eastern Conference)
        - `"Group Play - East Group B"` (Group B of the Eastern Conference)
        - `"Group Play - East Group C"` (Group C of the Eastern Conference)
        - `"Group Play - West Group A"` (Group A of the Western Conference)
        - `"Group Play - West Group B"` (Group B of the Western Conference)
        - `"Group Play - West Group C"` (Group C of the Western Conference)

    - `LastNGames`: The number of last games to consider.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 5`
      - _Default_: `0`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)

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

    - `OpponentTeamID`: The ID of the opposing team.
      - _Type(s)_: `Integer` | `String`
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
        - `"Totals"` (Total stats)
        - `"PerGame"` (Per game stats)
        - `"MinutesPer"` (Minutes per stats)
        - `"Per48"` (Per 48 minutes stats)
        - `"Per40"` (Per 40 minutes stats)
        - `"Per36"` (Per 36 minutes stats)
        - `"PerMinute"` (Per minute stats)
        - `"PerPossession"` (Per possession stats)
        - `"PerPlay"` (Per play stats)
        - `"Per100Possessions"` (Per 100 possessions stats)
        - `"Per100Plays"` (Per 100 plays stats)

    - `Period`: The period of the game.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1`
      - _Default_: `0`

    - `PORound`: The playoff round (if applicable, else 0).
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1`
      - _Default_: `0`

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

    - `StarterBench`: Whether the player is a starter or bench.
      - _Type(s)_: `String`
      - _Example_: `StarterBench: "Bench"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Starter"`
        - `"Bench"`

    - `TeamID`: The NBA team ID (use `0` for all teams).
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `0`

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

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashPtTeamDefend.get(Season: "2024-25", DefenseCategory: "Overall")
      {:ok, %{"LeagueDashPtTeamDefend" => [%{...}, ...]}}
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
