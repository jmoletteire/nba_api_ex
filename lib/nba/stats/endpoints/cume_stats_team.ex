defmodule NBA.Stats.CumeStatsTeam do
  @moduledoc """
  Handles requests to the cumulative team stats endpoint.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "cumestatsteam"

  @accepted_types %{
    LeagueID: [:string],
    TeamID: [:integer, :string],
    Season: [:string],
    SeasonType: [:string],
    GameIDs: [:string]
  }
  @default [LeagueID: "00", SeasonType: "Regular Season"]
  @required [:TeamID, :Season, :GameIDs]

  @doc """
  Fetches cumulative team stats for a given team ID and season.

  ## Parameters
  - `params`: A keyword list of parameters. Defaults to `@default`.
    - `LeagueID`: The league ID.
      - _Type(s)_: Numeric `String`
      - _Default_: `"00"` (NBA).
      - _Example_: `LeagueID: "10"` (for WNBA).
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)
    - `TeamID`: **(Required)** Team identifier (can be an integer or string).
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612752` (for the New York Knicks).
    - `Season`: **(Required)** Season identifier (e.g., "2024").
      - _Type(s)_: `String`
      - _Example_: `Season: "2024"`.
    - `SeasonType`: Type of season (default is "Regular Season").
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`.
      - _Example_: `SeasonType: "Playoffs"`.
      - _Valueset_:
        - `"Regular Season"`
        - `"Playoffs"`
        - `"Pre Season"`
        - `"All Star"`
    - `GameIDs`: **(Required)** String of game IDs to filter stats.
      - _Type(s)_: Numeric `String` values, separated by `|`.
      - _Example_: `GameIDs: "0022100001|0022100002"`.
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.CumeStatsTeam.get(GameIDs: "0042400305|0042400306", Team: 1610612752, Season: "2024", SeasonType: "Playoffs")
      {:ok, %{"GameByGameStats" => [...], "TotalTeamStats" => [...]}}
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
