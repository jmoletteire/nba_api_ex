defmodule NBA.Stats.LeagueDashTeamPtShot do
  @moduledoc """
  Provides access to team and opponent player tracking shot data from the NBA stats API.
  """

  @endpoints %{
    team: "leaguedashteamptshot",
    opp: "leaguedashoppptshot"
  }

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    Season: [:string],
    SeasonType: [:string],
    VsDivision: [:string],
    VsConference: [:string],
    TouchTimeRange: [:string],
    TeamID: [:integer, :string],
    ShotDistRange: [:string],
    ShotClockRange: [:string],
    SeasonSegment: [:string],
    Period: [:integer],
    PORound: [:integer],
    Outcome: [:string],
    OpponentTeamID: [:integer, :string],
    Month: [:integer],
    Location: [:string],
    LastNGames: [:integer],
    ISTRound: [:string],
    GeneralRange: [:string],
    GameSegment: [:string],
    DribbleRange: [:string],
    Division: [:string],
    DateTo: [:string],
    DateFrom: [:string],
    Conference: [:string],
    CloseDefDistRange: [:string]
  }

  @default [
    PerMode: "Totals",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
    GeneralRange: "Overall",
    TeamID: 0,
    Month: 0,
    OpponentTeamID: 0,
    Period: 0,
    LastNGames: 0
  ]

  @required [:Season]

  @doc """
  Fetches team opponent player tracking shot data.
  ## Parameters
  - `type`: The type of data to fetch.
    - `:team` for team data.
    - `:opp` for opponent data.
  - `params`: A keyword list of parameters to filter the data.
    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "10"` (for WNBA)
      - _Default_: `"00"` (NBA)
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"Totals"`
      - _Valueset_:
        - `"Totals"` (Total stats)
        - `"PerGame"` (Per game stats)

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2023-24"`
      - _Default_: `"2023-24"` (current season)

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Playoffs"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"` (Regular season)
        - `"Playoffs"` (Playoffs)
        - `"Pre Season"` (Pre-season)
        - `"All Star"` (All-Star game)

    - `VsDivision`: The division of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Central"` (Central Division)
      - _Default_: `"All"`
      - _Valueset_:
        - `"Atlantic"` (Atlantic Division)
        - `"Central"` (Central Division)
        - `"Southeast"` (Southeast Division)
        - `"Northwest"` (Northwest Division)
        - `"Pacific"` (Pacific Division)
        - `"Southwest"` (Southwest Division)
        - `"All"` (All divisions)

    - `VsConference`: The conference of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"` (Eastern Conference)
      - _Default_: `"All"`
      - _Valueset_:
        - `"East"` (Eastern Conference)
        - `"West"` (Western Conference)
        - `"All"` (All conferences)

    - `TouchTimeRange`: The range of touch time.
      - _Type(s)_: `String`
      - _Example_: `TouchTimeRange: "2-4"` (2-4 seconds of touch time)
      - _Default_: `"Overall"`
      - _Valueset_:
        - `"Overall"` (All touch times)
        - `"0-2"` (0-2 seconds)
        - `"2-4"` (2-4 seconds)
        - `"4-6"` (4-6 seconds)
        - `"6+"` (More than 6 seconds)

    - `TeamID`: The ID of the team.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `TeamID: 1610612756` (Los Angeles Lakers)
      - _Default_: `0` (all teams)

    - `ShotDistRange`: The range of shot distance.
      - _Type(s)_: `String`
      - _Example_: `ShotDistRange: "8-16"` (shots taken from 8-16 feet)
      - _Default_: `"Overall"`
      - _Valueset_:
        - `"Overall"` (All distances)
        - `"0-8"` (0-8 feet)
        - `"8-16"` (8-16 feet)
        - `"16-24"` (16-24 feet)
        - `"24+"` (More than 24 feet)

    - `ShotClockRange`: The range of the shot clock.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "0-14"` (shots taken with 0-14 seconds left)
      - _Default_: `"0-14"`
      - _Valueset_:
        - `"0-14"` (Shots taken with 0-14 seconds left)
        - `"14-24"` (Shots taken with 14-24 seconds left)
        - `"24+"` (Shots taken with more than 24 seconds left)

    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All Star"`
      - _Default_: `""`
      - _Valueset_:
        - `"Pre All Star"` (Before All-Star break)
        - `"Post All Star"` (After All-Star break)

    - `Period`: The period of the game.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1` (first period)
      - _Default_: `0` (all periods)

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1` (first round)
      - _Default_: `0` (not applicable)

    - `Outcome`: The outcome of the game.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"` (wins only)
      - _Default_: `"All"`
      - _Valueset_:
        - `"W"` (Wins)
        - `"L"` (Losses)
        - `"All"` (All games)

    - `OpponentTeamID`: The ID of the opponent team.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OpponentTeamID: 1610612739` (Golden State Warriors)
      - _Default_: `0` (all teams)

    - `Month`: The month of the season.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1` (January)
      - _Default_: `0` (all months)

    - `Location`: The location of the game.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"` (home games only)
      - _Default_: `"All"`
      - _Valueset_:
        - `"Home"` (Home games)
        - `"Away"` (Away games)
        - `"All"` (All games)

    - `LastNGames`: The number of last games to consider.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 5` (last 5 games)
      - _Default_: `0` (all games)

    - `ISTRound`: The round of the IST.
      - _Type(s)_: `String`
      - _Example_: `ISTRound: "All IST"` (all IST rounds)
      - _Default_: `""`
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

    - `GeneralRange`: The general range of the shot.
      - _Type(s)_: `String`
      - _Example_: `GeneralRange: "Overall"` (all shots)
      - _Default_: `"Overall"`
      - _Valueset_:
        - `"Overall"` (All shots)
        - `"Restricted Area"` (Shots in the restricted area)
        - `"In The Paint (Non-RA)"` (Shots in the paint excluding restricted area)
        - `"Mid-Range"` (Mid-range shots)
        - `"Left Corner 3"` (Left corner 3-point shots)
        - `"Right Corner 3"` (Right corner 3-point shots)
        - `"Above the Break 3"` (Above the break 3-point shots)

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"` (first half of the game)
      - _Default_: `"All"`
      - _Valueset_:
        - `"First Half"` (First half of the game)
        - `"Second Half"` (Second half of the game)
        - `"Overtime"` (Overtime periods)
        - `"All"` (All segments)

    - `DribbleRange`: The range of dribble time.
      - _Type(s)_: `String`
      - _Example_: `DribbleRange: "0-2"` (0-2 seconds of dribble time)
      - _Default_: `"Overall"`
      - _Valueset_:
        - `"Overall"` (All dribble times)
        - `"0-2"` (0-2 seconds)
        - `"2-4"` (2-4 seconds)
        - `"4-6"` (4-6 seconds)
        - `"6+"` (More than 6 seconds)

    - `Division`: The division of the team.
      - _Type(s)_: `String`
      - _Example_: `Division: "Pacific"` (Pacific Division)
      - _Default_: `"All"`
      - _Valueset_:
        - `"Atlantic"` (Atlantic Division)
        - `"Central"` (Central Division)
        - `"Southeast"` (Southeast Division)
        - `"Northwest"` (Northwest Division)
        - `"Pacific"` (Pacific Division)
        - `"Southwest"` (Southwest Division)
        - `"All"` (All divisions)

    - `DateTo`: The end date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2024-04-15"` (April 15, 2024)
      - _Default_: `""` (no end date)

    - `DateFrom`: The start date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2023-10-01"` (October 1, 2023)
      - _Default_: `""` (no start date)

    - `Conference`: The conference of the team.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"` (Western Conference)
      - _Default_: `"All"`
      - _Valueset_:
        - `"East"` (Eastern Conference)
        - `"West"` (Western Conference)
        - `"All"` (All conferences)

    - `CloseDefDistRange`: The range of close defender distance.
      - _Type(s)_: `String`
      - _Example_: `CloseDefDistRange: "0-2"` (0-2 feet from defender)
      - _Default_: `"Overall"`
      - _Valueset_:
        - `"Overall"` (All distances)
        - `"0-2"` (0-2 feet)
        - `"2-4"` (2-4 feet)
        - `"4-6"` (4-6 feet)
        - `"6+"` (More than 6 feet)

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.Stats.LeagueDashOppPtShot.get(Season: "2023-24")
      {:ok, %{"LeagueDashPTShots" => [%{...}, ...]}}
  """
  @spec get(atom(), keyword(), keyword()) :: {:ok, map()} | {:error, String.t()}
  def get(type, params \\ @default, opts \\ [])

  def get(type, params, opts) when is_atom(type) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         endpoint when not is_nil(endpoint) <- Map.get(@endpoints, type),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      nil ->
        {:error, "Endpoint #{inspect(type)} is not supported."}

      err ->
        NBA.Utils.handle_validation_error(err)
    end
  end

  def get(type, _params, _opts) do
    {:error, "Received endpoint type #{inspect(type)}, expected atom :#{type}"}
  end

  def get!(type, params \\ @default, opts \\ []) do
    case get(type, params, opts) do
      {:ok, data} -> data
      {:error, reason} -> raise "Failed to fetch team shot data: #{reason}"
    end
  end
end
