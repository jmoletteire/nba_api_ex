defmodule NBA.Stats.PlayerDashboard do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerDashboard.

  See `get/2` for parameter and usage details.
  """

  @endpoints %{
    clutch: "playerdashboardbyclutch",
    game_splits: "playerdashboardbygamesplits",
    general_splits: "playerdashboardbygeneralsplits",
    last_n_games: "playerdashboardbylastngames",
    shooting_splits: "playerdashboardbyshootingsplits",
    team_performance: "playerdashboardbyteamperformance",
    year_over_year: "playerdashboardbyyearoveryear"
  }

  @accepted_types %{
    LastNGames: [:integer],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlayerID: [:integer, :string],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonType: [:string],
    VsDivision: [:string],
    VsConference: [:string],
    ShotClockRange: [:string],
    SeasonSegment: [:string],
    TeamID: [:integer, :string],
    PORound: [:integer, :string],
    Outcome: [:string],
    Location: [:string],
    LeagueID: [:string],
    GameSegment: [:string],
    DateTo: [:string],
    DateFrom: [:string]
  }

  @default [
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerID: nil,
    PlusMinus: "N",
    Rank: "N",
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: 0,
    VsDivision: nil,
    VsConference: nil,
    ShotClockRange: nil,
    SeasonSegment: nil,
    PORound: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: "00",
    GameSegment: nil,
    DateTo: nil,
    DateFrom: nil
  ]

  @required [:PlayerID, :Season]

  @doc """
  Fetches PlayerDashboardByClutch data.

  ## Parameters
  - `type`: The type of data to fetch. This should be one of the keys in `@endpoints`, such as `:clutch`, `:game_splits`, etc.
    - `clutch`: Fetches clutch stats.
    - `game_splits`: Fetches game splits stats.
    - `general_splits`: Fetches general splits stats.
    - `last_n_games`: Fetches stats for the last N games.
    - `shooting_splits`: Fetches shooting splits stats.
    - `team_performance`: Fetches team performance stats.
    - `year_over_year`: Fetches year-over-year stats.

  - `params`: A keyword list of parameters to filter the data.

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `LastNGames`: Number of last games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 10`
      - _Default_: `0`

    - `MeasureType`: The type of measure.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `"Base"`
      - _Valueset_:
        - `"Base"`
        - `"Advanced"`
        - `"Misc"`
        - `"Four Factors"`
        - `"Scoring"`
        - `"Opponent"`
        - `"Usage"`

    - `Month`: The month number.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `0`

    - `OpponentTeamID`: The opponent team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612737`
      - _Default_: `0`

    - `PaceAdjust`: Whether to adjust for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
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

    - `Period`: The period number.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 1`
      - _Default_: `0`

    - `PlusMinus`: Whether to include plus/minus.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Rank`: Whether to include rank.
      - _Type(s)_: `String`
      - _Example_: `Rank: "Y"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`

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

    - `ShotClockRange`: The shot clock range.
      - _Type(s)_: `String`
      - _Example_: `ShotClockRange: "24-22"`
      - _Default_: `nil`
      - _Valueset_:
        - `"24-22"`
        - `"22-18 Very Early"`
        - `"18-15 Early"`
        - `"15-7 Average"`
        - `"7-4 Late"`
        - `"4-0 Very Late"`
        - `"ShotClock Off"`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Pre All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `TeamID`: The team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `0` (all teams)

    - `PORound`: The playoff round.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1`
      - _Default_: `nil`

    - `Outcome`: The outcome.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

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
      iex> NBA.Stats.PlayerDashboard.get(:clutch, PlayerID: 201939, Season: "2024-25")
      {:ok, %{"PlayerDashboardByClutch" => [%{...}, ...]}}
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
      {:error, reason} -> raise "Failed to fetch player dashboard data: #{reason}"
    end
  end
end
