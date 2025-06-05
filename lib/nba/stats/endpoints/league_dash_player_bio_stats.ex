defmodule NBA.Stats.LeagueDashPlayerBioStats do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league dash player bio stats.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguedashplayerbiostats"

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    Season: [:string],
    SeasonType: [:string],
    College: [:string],
    Conference: [:string],
    Country: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    DraftPick: [:string],
    DraftYear: [:string],
    GameScope: [:string],
    GameSegment: [:string],
    Height: [:string],
    LastNGames: [:integer],
    Location: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PORound: [:integer],
    Period: [:integer],
    PlayerExperience: [:string],
    PlayerPosition: [:string],
    SeasonSegment: [:string],
    ShotClockRange: [:string],
    StarterBench: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string],
    Weight: [:string]
  }

  @default [
    LeagueID: "00",
    PerMode: "Totals",
    SeasonType: "Regular Season"
  ]

  @required [:LeagueID, :PerMode, :Season, :SeasonType]

  @doc """
  Fetches league dash player bio stats data.

  ## Parameters
  See NBA API documentation for full list of supported parameters.

  ## Returns
  - `{:ok, data}` on success
  - `{:error, reason}` on failure

  ## Example
      iex> NBA.Stats.LeagueDashPlayerBioStats.get(Season: "2023-24")
      {:ok, %{"LeagueDashPlayerBioStats" => [%{...}, ...]}}
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
