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
  Fetches team or opponent player tracking shot data.

  ## Parameters
  - `type`: The type of data to fetch.
    - `:team` for team data.
    - `:opp` for opponent data.
  - `params`: A keyword list of parameters to filter the data.

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `"Totals"`
      - _Valueset_:
        - "Totals"
        - "PerGame"
        - "Per48"
        - "Per40"
        - "Per36"
        - "PerMinute"
        - "PerPossession"
        - "PerPlay"
        - "Per100Possessions"
        - "Per100Plays"

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - "00"
        - "10"
        - "20"

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Playoffs"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - "Regular Season"
        - "Playoffs"
        - "Pre Season"
        - "All Star"
        - "Play In"

    - `VsDivision`: The division of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Central"`
      - _Default_: `nil`
      - _Valueset_:
        - "Atlantic"
        - "Central"
        - "Southeast"
        - "Northwest"
        - "Pacific"
        - "Southwest"

    - `VsConference`: The conference of the opponent.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"`
      - _Default_: `nil`
      - _Valueset_:
        - "East"
        - "West"

    - `TouchTimeRange`: The touch time range for filtering.
      - _Type(s)_: `String`
      - _Example_: `TouchTimeRange: "Touch < 2 Seconds"`
      - _Default_: `nil`
      - _Valueset_:
        - "Touch < 2 Seconds"
        - "Touch 2-6 Seconds"
        - "Touch 6+ Seconds"

    - `TeamID`: The NBA team ID (use `0` for league-wide).
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `0`

    - `ShotDistRange`: The shot distance range.
      - _Type(s)_: `String`
      - _Example_: `ShotDistRange: "8-16 ft."`
      - _Default_: `nil`
      - _Valueset_:
        - "Less Than 8 ft."
        - "8-16 ft."
        - "16-24 ft."
        - "24+ ft."
        - "Backcourt"

    - `ShotClockRange`: The range of the shot clock.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "24+"`
      - _Default_: `nil`
      - _Valueset_:
        - "24+"
        - "22-18"
        - "15-7"
        - "4-0"
        - "NA"

    - `SeasonSegment`: The segment of the season.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All Star"`
      - _Default_: `nil`
      - _Valueset_:
        - "Pre All Star"
        - "Post All Star"

    - `Period`: The period of the game.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1`
      - _Default_: `0`

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1`
      - _Default_: `0`

    - `Outcome`: The outcome of the game.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - "W"
        - "L"

    - `OpponentTeamID`: The ID of the opponent team.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612739`
      - _Default_: `0`

    - `Month`: The month of the season.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `0`

    - `Location`: The location of the game.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - "Home"
        - "Away"

    - `LastNGames`: The number of last games to consider.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 5`
      - _Default_: `0`

    - `ISTRound`: The round of the In-Season Tournament.
      - _Type(s)_: `String`
      - _Example_: `ISTRound: "All IST"`
      - _Default_: `nil`

    - `GeneralRange`: The general range for filtering.
      - _Type(s)_: `String`
      - _Example_: `GeneralRange: "Overall"`
      - _Default_: `"Overall"`
      - _Valueset_:
        - "Overall"
        - "Catch and Shoot"
        - "Pull Up"
        - "Less Than 10 ft."
        - "10-16 ft."
        - "16-24 ft."
        - "24+ ft."

    - `GameSegment`: The segment of the game.
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - "First Half"
        - "Second Half"
        - "Overtime"

    - `DribbleRange`: The dribble range for filtering.
      - _Type(s)_: `String`
      - _Example_: `DribbleRange: "0 Dribbles"`
      - _Default_: `nil`
      - _Valueset_:
        - "0 Dribbles"
        - "1 Dribble"
        - "2 Dribbles"
        - "3-6 Dribbles"
        - "7+ Dribbles"

    - `Division`: The division of the team.
      - _Type(s)_: `String`
      - _Example_: `Division: "Pacific"`
      - _Default_: `nil`
      - _Valueset_:
        - "Atlantic"
        - "Central"
        - "Southeast"
        - "Northwest"
        - "Pacific"
        - "Southwest"

    - `DateTo`: The end date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2024-04-15"`
      - _Default_: `nil`

    - `DateFrom`: The start date for filtering.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2023-10-01"`
      - _Default_: `nil`

    - `Conference`: The conference of the team.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - "East"
        - "West"

    - `CloseDefDistRange`: The defender distance range.
      - _Type(s)_: `String`
      - _Example_: `CloseDefDistRange: "0-2 Feet"`
      - _Default_: `nil`
      - _Valueset_:
        - "0-2 Feet"
        - "2-4 Feet"
        - "4-6 Feet"
        - "6+ Feet"

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashTeamPtShot.get(:team, Season: "2024-25")
      {:ok, %{"LeagueDashTeamPtShot" => [%{...}, ...]}}
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
