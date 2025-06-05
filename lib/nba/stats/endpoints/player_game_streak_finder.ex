defmodule NBA.Stats.PlayerGameStreakFinder do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league game finder.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playergamestreakfinder"

  @accepted_types %{
    ActiveStreaksOnly: [:string],
    Conference: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    DraftNumber: [:integer],
    DraftRound: [:integer],
    DraftTeamID: [:integer, :string],
    DraftYear: [:integer],
    GameID: [:string],
    LeagueID: [:string],
    Location: [:string],
    Outcome: [:string],
    PORound: [:integer],
    PlayerID: [:integer, :string],
    RookieYear: [:string],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    StarterBench: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string],
    VsTeamID: [:integer, :string],
    YearsExperience: [:integer],
    LtAST: [:integer],
    LtBLK: [:integer],
    LtDD: [:integer],
    LtDREB: [:integer],
    LtFG3A: [:integer],
    LtFG3M: [:integer],
    LtFG3_PCT: [:float],
    LtFGA: [:integer],
    LtFGM: [:integer],
    LtFG_PCT: [:float],
    LtFTA: [:integer],
    LtFTM: [:integer],
    LtFT_PCT: [:float],
    LtMINUTES: [:integer],
    LtOREB: [:integer],
    LtPF: [:integer],
    LtPTS: [:integer],
    LtREB: [:integer],
    LtSTL: [:integer],
    LtTD: [:integer],
    LtTOV: [:integer],
    GtAST: [:integer],
    GtBLK: [:integer],
    GtDD: [:integer],
    GtDREB: [:integer],
    GtFG3A: [:integer],
    GtFG3M: [:integer],
    GtFG3_PCT: [:float],
    GtFGA: [:integer],
    GtFGM: [:integer],
    GtFG_PCT: [:float],
    GtFTA: [:integer],
    GtFTM: [:integer],
    GtFT_PCT: [:float],
    GtMINUTES: [:integer],
    GtOREB: [:integer],
    GtPF: [:integer],
    GtPTS: [:integer],
    GtREB: [:integer],
    GtSTL: [:integer],
    GtTD: [:integer],
    GtTOV: [:integer],
    EqAST: [:integer],
    EqBLK: [:integer],
    EqDD: [:integer],
    EqDREB: [:integer],
    EqFG3A: [:integer],
    EqFG3M: [:integer],
    EqFG3_PCT: [:float],
    EqFGA: [:integer],
    EqFGM: [:integer],
    EqFG_PCT: [:float],
    EqFTA: [:integer],
    EqFTM: [:integer],
    EqFT_PCT: [:float],
    EqMINUTES: [:integer],
    EqOREB: [:integer],
    EqPF: [:integer],
    EqPTS: [:integer],
    EqREB: [:integer],
    EqSTL: [:integer],
    EqTD: [:integer],
    EqTOV: [:integer]
  }

  @default [
    ActiveStreaksOnly: nil,
    Conference: nil,
    DateFrom: nil,
    DateTo: nil,
    Division: nil,
    DraftNumber: nil,
    DraftRound: nil,
    DraftTeamID: nil,
    DraftYear: nil,
    GameID: nil,
    LeagueID: "00",
    Location: nil,
    MinGames: 0,
    Outcome: nil,
    PlayerID: nil,
    PORound: 0,
    RookieYear: nil,
    Season: nil,
    SeasonSegment: nil,
    SeasonType: "Regular Season",
    StarterBench: nil,
    TeamID: 0,
    VsConference: nil,
    VsDivision: nil,
    VsTeamID: nil,
    YearsExperience: nil,
    LtAST: nil,
    LtBLK: nil,
    LtDD: nil,
    LtDREB: nil,
    LtFG3A: nil,
    LtFG3M: nil,
    LtFG3_PCT: nil,
    LtFGA: nil,
    LtFGM: nil,
    LtFG_PCT: nil,
    LtFTA: nil,
    LtFTM: nil,
    LtFT_PCT: nil,
    LtMINUTES: nil,
    LtOREB: nil,
    LtPF: nil,
    LtPTS: nil,
    LtREB: nil,
    LtSTL: nil,
    LtTD: nil,
    LtTOV: nil,
    GtAST: nil,
    GtBLK: nil,
    GtDD: nil,
    GtDREB: nil,
    GtFG3A: nil,
    GtFG3M: nil,
    GtFG3_PCT: nil,
    GtFGA: nil,
    GtFGM: nil,
    GtFG_PCT: nil,
    GtFTA: nil,
    GtFTM: nil,
    GtFT_PCT: nil,
    GtMINUTES: nil,
    GtOREB: nil,
    GtPF: nil,
    GtPTS: nil,
    GtREB: nil,
    GtSTL: nil,
    GtTD: nil,
    GtTOV: nil,
    EqAST: nil,
    EqBLK: nil,
    EqDD: nil,
    EqDREB: nil,
    EqFG3A: nil,
    EqFG3M: nil,
    EqFG3_PCT: nil,
    EqFGA: nil,
    EqFGM: nil,
    EqFG_PCT: nil,
    EqFTA: nil,
    EqFTM: nil,
    EqFT_PCT: nil,
    EqMINUTES: nil,
    EqOREB: nil,
    EqPF: nil,
    EqPTS: nil,
    EqREB: nil,
    EqSTL: nil,
    EqTD: nil,
    EqTOV: nil
  ]

  @required [:PlayerID, :Season]

  @doc """
  Fetches league game finder data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - _**Note**_: This endpoint also supports a wide range of advanced stat filters in the form of `LtX`, `GtX`, and `EqX` (e.g., `LtPTS`, `GtAST`, `EqREB`), where `X` is a stat name. These accept `Integer` or `Float` values and default to `nil`.
      - `LtX`: "Less than" filter for statistic `X`.
        - _Type(s)_: `Integer` or `Float`
        - _Example_: `LtPTS: 20`
        - _Default_: `nil`
      - `GtX`: "Greater than" filter for statistic `X`.
        - _Type(s)_: `Integer` or `Float`
        - _Example_: `GtPTS: 30`
        - _Default_: `nil`
      - `EqX`: "Equal to" filter for statistic `X`.
        - _Type(s)_: `Integer` or `Float`
        - _Example_: `EqPTS: 25`
        - _Default_: `nil`

    - `PlayerID`: **(Required)** The NBA player ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `ActiveStreaksOnly`: Filter for active streaks only.
      - _Type(s)_: `String`
      - _Example_: `ActiveStreaksOnly: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"` (Yes)
        - `"N"` (No)

    - `Conference`: The conference of the team.
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

    - `DraftNumber`: The draft number.
      - _Type(s)_: `Integer`
      - _Example_: `DraftNumber: 1`
      - _Default_: `nil`

    - `DraftRound`: The draft round.
      - _Type(s)_: `Integer`
      - _Example_: `DraftRound: 1`
      - _Default_: `nil`

    - `DraftTeamID`: The draft team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `DraftTeamID: 1610612747`
      - _Default_: `nil`

    - `DraftYear`: The draft year of the player.
      - _Type(s)_: `Integer`
      - _Example_: `DraftYear: 2019`
      - _Default_: `nil`

    - `GameID`: The NBA game ID.
      - _Type(s)_: `String`
      - _Example_: `GameID: "0022100001"`
      - _Default_: `nil`

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Second Half"`
        - `"Overtime"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)

    - `Location`: Game location ("Home", "Away", or nil for all).
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Away"`

    - `MinGames`: Minimum number of games played.
      - _Type(s)_: `Integer`
      - _Example_: `MinGames: 5`
      - _Default_: `0`

    - `Outcome`: Game outcome ("W", "L", or nil for all).
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PORound`: The playoff round (0 for regular season).
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 0`
      - _Default_: `0`

    - `RookieYear`: The rookie year of the player.
      - _Type(s)_: `String`
      - _Example_: `RookieYear: "2019"`
      - _Default_: `nil`

    - `SeasonSegment`: Season segment ("Post All-Star", "Pre All-Star", or nil).
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
        - `"Playoffs"`
        - `"Pre Season"`
        - `"All Star"`

    - `StarterBench`: Whether the player is a starter or bench.
      - _Type(s)_: `String`
      - _Example_: `StarterBench: "Bench"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Starter"`
        - `"Bench"`

    - `TeamID`: Team ID (0 for all teams).
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 0`
      - _Default_: `0`

    - `VsConference`: Opponent conference filter ("East", "West", or nil).
      - _Type(s)_: `String`
      - _Example_: `VsConference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: Opponent division filter (e.g., "Atlantic", "Central", etc., or nil).
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

    - `VsTeamID`: The opposing team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `VsTeamID: 1610612747`
      - _Default_: `nil`

    - `YearsExperience`: Years of NBA experience.
      - _Type(s)_: `Integer`
      - _Example_: `YearsExperience: 5`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueGameFinder.get(LeagueID: "00", PlayerOrTeam: "P")
      {:ok, %{"LeagueGameFinder" => [%{...}, ...]}}
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
