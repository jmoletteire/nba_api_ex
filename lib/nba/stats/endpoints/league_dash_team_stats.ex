defmodule NBA.Stats.LeagueDashTeamStats do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league dash team stats.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashteamstats"

  @accepted_types %{
    Conference: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    GameScope: [:string],
    GameSegment: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlayerExperience: [:string],
    PlayerPosition: [:string],
    PlusMinus: [:string],
    PORound: [:integer],
    Rank: [:string],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    ShotClockRange: [:string],
    StarterBench: [:string],
    TeamID: [:integer, :string],
    TwoWay: [:string],
    VsConference: [:string],
    VsDivision: [:string]
  }

  @default [
    Conference: "",
    DateFrom: "",
    DateTo: "",
    Division: "",
    GameScope: "",
    GameSegment: "",
    LastNGames: 0,
    LeagueID: "00",
    Location: "",
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    Outcome: "",
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerExperience: "",
    PlayerPosition: "",
    PlusMinus: "N",
    PORound: 0,
    Rank: "N",
    SeasonSegment: "",
    SeasonType: "Regular Season",
    ShotClockRange: "",
    StarterBench: "",
    TeamID: 0,
    TwoWay: "",
    VsConference: "",
    VsDivision: ""
  ]

  @required [:Season]

  @doc """
  Fetches league dash team stats data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.
    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`
    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Default_: `"PerGame"`
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
    - `MeasureType`: The type of measure to return.
      - _Type(s)_: `String`
      - _Default_: `"Base"`
      - _Valueset_:
        - "Base"
        - "Advanced"
        - "Misc"
        - "Four Factors"
        - "Scoring"
        - "Opponent"
        - "Usage"
    - `PlusMinus`: Whether to include plus/minus splits.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - "Y"
        - "N"
    - `PaceAdjust`: Whether to adjust stats for pace.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - "Y"
        - "N"
    - `Rank`: Whether to include team rank.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - "Y"
        - "N"
    - `LeagueID`: The league ID ("00" for NBA, "20" for G-League).
      - _Type(s)_: `String`
      - _Default_: `"00"`
      - _Valueset_:
        - "00"
        - "20"
    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - "Regular Season"
        - "Pre Season"
        - "Playoffs"
        - "All Star"
    - `PORound`: Playoff round (0 for regular season).
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `Month`: Month filter (0 for all months).
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `OpponentTeamID`: Opponent team ID (0 for all teams).
      - _Type(s)_: `Integer` | `String`
      - _Default_: `0`
    - `TeamID`: Team ID (0 for all teams).
      - _Type(s)_: `Integer` | `String`
      - _Default_: `0`
    - `Period`: Period filter (0 for all periods).
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `LastNGames`: Number of most recent games to include (0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`
    - `Conference`, `Division`, `GameScope`, `GameSegment`, `DateFrom`, `DateTo`, `Location`, `Outcome`, `SeasonSegment`, `PlayerExperience`, `PlayerPosition`, `ShotClockRange`, `StarterBench`, `TwoWay`, `VsConference`, `VsDivision`: See official NBA API docs for accepted values and usage.
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueDashTeamStats.get(Season: "2024-25")
      {:ok, %{"LeagueDashTeamStats" => [%{...}, ...]}}
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
