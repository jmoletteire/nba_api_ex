defmodule NBA.Stats.LeagueDashLineups do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league dash lineups.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashlineups"

  @accepted_types %{
    MeasureType: [:string],
    PerMode: [:string],
    PlusMinus: [:string],
    PaceAdjust: [:string],
    Rank: [:string],
    LeagueID: [:string],
    Season: [:string],
    SeasonType: [:string],
    PORound: [:integer],
    Outcome: [:string],
    Location: [:string],
    Month: [:integer],
    SeasonSegment: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    OpponentTeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string],
    TeamID: [:integer, :string],
    Conference: [:string],
    Division: [:string],
    GameSegment: [:string],
    Period: [:integer],
    ShotClockRange: [:string],
    LastNGames: [:integer],
    GroupQuantity: [:integer],
    ISTRound: [:string]
  }

  @default [
    MeasureType: "Base",
    PerMode: "Totals",
    PlusMinus: "N",
    PaceAdjust: "N",
    Rank: "N",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
    Month: 0,
    OpponentTeamID: 0,
    TeamID: 0,
    Period: 0,
    LastNGames: 0,
    GroupQuantity: 5
  ]

  @required [:Season]

  @doc """
  Fetches league lineup data.
  ## Parameters
  - `params`: A keyword list of parameters to filter the data.
    - `Conference`: The conference of the team.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"` (Western Conference)
      - _Default_: `nil` (no specific conference)
      - _Valueset_:
        - `"East"` (Eastern Conference)
        - `"West"` (Western Conference)

    - `DateFrom`: The start date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2023-10-01"` (October 1, 2023)
      - _Default_: `nil` (no start date)

    - `DateTo`: The end date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2024-04-15"` (April 15, 2024)
      - _Default_: `nil` (no end date)

    - `Division`: The division of the team.
      - _Type(s)_: `String`
      - _Example_: `Division: "Pacific"` (Pacific Division)
      - _Default_: `nil` (no specific division)
      - _Valueset_:
        - `"Atlantic"` (Atlantic Division)
        - `"Central"` (Central Division)
        - `"Southeast"` (Southeast Division)
        - `"Northwest"` (Northwest Division)
        - `"Pacific"` (Pacific Division)
        - `"Southwest"` (Southwest Division)

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"` (first half of the game)
      - _Default_: `nil` (no specific segment)
      - _Valueset_:
        - `"First Half"` (First half of the game)
        - `"Second Half"` (Second half of the game)
        - `"Overtime"` (Overtime periods)

    - `GroupQuantity`: The number of players in the lineup.
      - _Type(s)_: `Integer`
      - _Example_: `GroupQuantity: 5` (5-player lineups)
      - _Default_: `5` (default to 5-player lineups)

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
      - _Example_: `LastNGames: 5` (last 5 games)
      - _Default_: `0` (all games)

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "10"` (for WNBA)
      - _Default_: `"00"` (NBA)
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)

    - `Location`: The location of the game.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"` (home games only)
      - _Default_: `nil` (no specific location)
      - _Valueset_:
        - `"Home"` (Home games)
        - `"Away"` (Away games)

    - `MeasureType`: Type of measures.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Advanced"`
      - _Default_: `"Base"`
      - _Valueset_:
        - `"Base"` (Basic stats)
        - `"Advanced"` (Advanced stats)
        - `"Scoring"` (Scoring stats)
        - `"Misc"` (Miscellaneous stats)
        - `"FourFactors"` (Four factors stats)
        - `"Defense"` (Defensive stats)
        - `"Usage"` (Usage stats)

    - `Month`: The month of the season.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1` (January)
      - _Default_: `0` (all months)

    - `OpponentTeamID`: The ID of the opponent team.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612739` (Golden State Warriors)
      - _Default_: `0` (all teams)

    - `Outcome`: The outcome of the game.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"` (wins only)
      - _Default_: `nil` (no specific outcome)
      - _Valueset_:
        - `"W"` (Wins)
        - `"L"` (Losses)
        - `"All"` (All games)

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1` (first round)
      - _Default_: `0` (not applicable)

    - `PaceAdjust`: Whether to adjust stats for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"` (Adjust for pace)
        - `"N"` (Do not adjust for pace)

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"Totals"`
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
      - _Example_: `Period: 1` (first period)
      - _Default_: `0` (all periods)

    - `PlusMinus`: Whether to include plus/minus stats.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"` (Include plus/minus)
        - `"N"` (Exclude plus/minus)

    - `Rank`: Whether to include rank in stats.
      - _Type(s)_: `String`
      - _Example_: `Rank: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"` (Include rank)
        - `"N"` (Do not include rank)

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2023-24"`
      - _Default_: `"2023-24"` (current season)

    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All Star"`
      - _Default_: `nil` (no specific segment)
      - _Valueset_:
        - `"Pre All Star"` (Before All-Star break)
        - `"Post All Star"` (After All-Star break)

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Playoffs"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"` (Regular season)
        - `"Playoffs"` (Playoffs)
        - `"Pre Season"` (Pre-season)
        - `"All Star"` (All-Star game)
        - `"Play In"` (Play-In tournament)
        - `"NBA Cup"` (NBA Cup)

    - `ShotClockRange`: The range of the shot clock.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "14-24"` (shots taken with 14-24 seconds left)
      - _Default_: `nil` (no specific range)
      - _Valueset_:
        - `"0-14"` (Shots taken with 0-14 seconds left)
        - `"14-24"` (Shots taken with 14-24 seconds left)
        - `"24+"` (Shots taken with more than 24 seconds left)

    - `TeamID`: The ID of the team.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612756` (Los Angeles Lakers)
      - _Default_: `0` (all teams)

    - `VsConference`: The conference of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"` (Eastern Conference)
      - _Default_: `nil` (no specific conference)
      - _Valueset_:
        - `"East"` (Eastern Conference)
        - `"West"` (Western Conference)

    - `VsDivision`: The division of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Central"` (Central Division)
      - _Default_: `nil` (no specific division)
      - _Valueset_:
        - `"Atlantic"` (Atlantic Division)
        - `"Central"` (Central Division)
        - `"Southeast"` (Southeast Division)
        - `"Northwest"` (Northwest Division)
        - `"Pacific"` (Pacific Division)
        - `"Southwest"` (Southwest Division)

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashLineups.get(Season: "2023-24")
      {:ok, %{"Lineups" => [%{...}, ...]}}
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
