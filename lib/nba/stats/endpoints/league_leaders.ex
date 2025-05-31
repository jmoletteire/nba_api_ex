defmodule NBA.Stats.LeagueLeaders do
  @moduledoc """
  Fetches all-time leaders data for NBA players.

  ## Example

      NBA.Stats.LeagueLeaders.get()
      {:ok, [%{"PLAYER_ID" => 2544, ...}, ...]}

  ## Notes
  - The `PLAYER_ID` field indicates the ID of the player.
  - The `SEASON` field indicates the season in which the record was set.
  - The `TYPE` field indicates the type of record (e.g., "Points", "Rebounds").
  """

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leagueLeaders"

  @default [
    LeagueID: "00",
    PerMode: "Totals",
    StatCategory: "PTS",
    Season: "All Time",
    SeasonType: "Regular Season",
    Scope: "S",
    ActiveFlag: "No"
  ]

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    StatCategory: [:string],
    Season: [:string],
    SeasonType: [:string],
    Scope: [:string],
    ActiveFlag: [:string]
  }

  @doc """
  Fetches league leaders data.

  ## Parameters
  - `params`: Optional parameters for the request (e.g., PlayerID, Season).
    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"` (NBA)
      - _Example_: `LeagueID: "10"`
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
        - `"Per48"` (Per 48 minutes stats)
        - `"Per100Possessions"` (Per 100 possessions stats)
        - `"Per40Minutes"` (Per 40 minutes stats)
        - `"Per36Minutes"` (Per 36 minutes stats)
        - `"PerMinute"` (Per minute stats)
        - `"PerPossession"` (Per possession stats)
    - `StatCategory`: The category of stats to filter by (e.g., "PTS", "REB").
      - _Type(s)_: `String`
      - _Default_: `"PTS"` (Points)
      - _Example_: `StatCategory: "REB"` (Rebounds)
      - _Valueset_:
        - `"PTS"` (Points)
        - `"REB"` (Rebounds)
        - `"AST"` (Assists)
        - `"STL"` (Steals)
        - `"BLK"` (Blocks)
        - `"TO"` (Turnovers)
        - `"FGM"` (Field Goals Made)
        - `"FGA"` (Field Goals Attempted)
        - `"FG_PCT"` (Field Goal Percentage)
        - ... and more.
    - `Season`: The season to filter the data by (e.g., "2022-23").
      - _Type(s)_: `String`
      - _Default_: `"All Time"` (for all-time leaders)
      - _Example_: `Season: "2022-23"`
      - _Valueset_:
        - `"All Time"` (for all-time leaders)
        - Specific seasons (e.g, "2024-25").
    - `SeasonType`: The type of season (e.g., "Regular Season", "Playoffs").
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Example_: `SeasonType: "Playoffs"`
      - _Valueset_:
        - `"Regular Season"` (Regular season stats)
        - `"Playoffs"` (Playoff stats)
    - `Scope`: The scope of the data (e.g., "All", "Home", "Away").
      - _Type(s)_: `String`
      - _Default_: `"S"` (Season)
      - _Example_: `Scope: "A"` (All games)
      - _Valueset_:
        - `"S"` (Season)
        - `"A"` (All games)
        - `"H"` (Home games)
        - `"R"` (Road games)
    - `ActiveFlag`: A flag to indicate if only active players should be included.
      - _Type(s)_: `String`
      - _Default_: `"No"` (include all players)
      - _Example_: `ActiveFlag: "Yes"` (only active players)
      - _Valueset_:
        - `"Yes"` (only active players)
        - `"No"` (all players, including retired)
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.Stats.LeagueLeaders.get()
      {:ok, [%{"PLAYER_ID" => 2544, ...}, ...]}

  ## Returns
  - `{:ok, leaders}`: A map of all-time leaders data.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Notes
  - Data availability depends on the league, season type, stat category, and other parameters. Some combinations may return no data.
  - For All-Time Leaders, the `Season` parameter can be set to "All Time".
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types) do
      params = Keyword.merge(@default, params)

      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
