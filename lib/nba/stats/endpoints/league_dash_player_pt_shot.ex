defmodule NBA.Stats.LeagueDashPlayerPtShot do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league dash player point shot stats.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashplayerptshot"

  @accepted_types %{
    CloseDefDistRange: [:string],
    College: [:string],
    Conference: [:string],
    Country: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    DraftPick: [:string],
    DraftYear: [:string],
    DribbleRange: [:string],
    GameScope: [:string],
    GameSegment: [:string],
    Height: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PORound: [:integer],
    PerMode: [:string],
    Period: [:integer],
    PlayerExperience: [:string],
    PlayerPosition: [:string],
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
    MeasureType: "Base",
    PerMode: "Totals",
    PlusMinus: "Y",
    PaceAdjust: "Y",
    Rank: "Y",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
    Month: 0,
    OpponentTeamID: 0,
    TeamID: 0,
    Period: 0,
    LastNGames: 0
  ]

  @required [:Season]

  @doc """
  Fetches league dash player point shot stats data.

  ## Parameters
  See NBA API documentation for full list of supported parameters.

  ## Returns
  - `{:ok, data}` on success
  - `{:error, reason}` on failure

  ## Example
      iex> NBA.Stats.LeagueDashPlayerPtShot.get(Season: "2024-25")
      {:ok, %{"LeagueDashPlayerPtShot" => [%{...}, ...]}}
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
