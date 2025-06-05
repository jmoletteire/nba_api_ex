defmodule NBA.Stats.LeagueDashPtTeamDefend do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league player tracking team defend stats.

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

    - `TeamID`: The NBA team ID (use `0` for league-wide).
      - _Type(s)_: `Integer` or `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `0`

    - `ISTRound`: The round of the In-Season Tournament.
      - _Type(s)_: `String`
      - _Example_: `ISTRound: "All IST"`
      - _Default_: `nil`

    # ...document other parameters as in previous examples...

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
