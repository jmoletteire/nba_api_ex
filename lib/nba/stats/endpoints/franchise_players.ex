defmodule NBA.Stats.FranchisePlayers do
  @moduledoc """
  Handles requests to the `franchiseplayers` endpoint of the NBA stats API.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "franchiseplayers"

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    SeasonType: [:string],
    TeamID: [:integer, :string]
  }
  @default [LeagueID: "00", PerMode: "Totals", SeasonType: "Regular Season"]
  @required [:TeamID]

  @doc """
  Fetches franchise player data for a specific team.

  ## Parameters
  - `params`: A keyword list of parameters, including:
    - `LeagueID`: The league ID.
        - _Type(s)_: Numeric `String`.
        - _Default_: `"00"` (NBA).
        - _Example_: `LeagueID: "10"` (for WNBA).
        - _Valueset_:
          - `"00"` (NBA)
          - `"01"` (ABA)
          - `"10"` (WNBA)
          - `"20"` (G-League)
    - `PerMode`: The mode for per-game stats (e.g., "PerGame", "Totals").
      - _Type(s)_: `String`
      - _Default_: `"Totals"`
      - _Example_: `PerMode: "PerGame"`
      - _Valueset_:
        - `"Totals"` (Total stats)
        - `"PerGame"` (Per game stats)
        - `"MinutesPer"` (Per minute stats)
        - `"Per48"` (Per 48 minutes stats)
        - `"Per40"` (Per 40 minutes stats)
        - `"Per36"` (Per 36 minutes stats)
        - `"PerMinute"` (Per minute stats)
        - `"PerPossession"` (Per possession stats)
        - `"PerPlay"` (Per play stats)
        - `"Per100Possessions"` (Per 100 possessions stats)
        - `"Per100Plays"` (Per 100 plays stats)
    - `SeasonType`: Type of season (default is "Regular Season").
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`.
      - _Example_: `SeasonType: "Playoffs"`.
      - _Valueset_:
        - `"Regular Season"`
        - `"Playoffs"`
        - `"Pre Season"`
        - `"All Star"`
    - `TeamID`: **(Required)** The team ID
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.FranchisePlayers.get(TeamID: 1610612756)
      {:ok, [%{"PlayerID" => 2544, "PlayerName" => "LeBron James", ...}]}
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
