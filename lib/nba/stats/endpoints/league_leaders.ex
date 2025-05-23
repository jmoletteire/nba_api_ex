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

  @endpoint "leagueLeaders"

  @doc """
  Fetches league leaders data.
  ## Parameters
  - `params`: Optional parameters for the request (e.g., PlayerID, Season).
    - `LeagueID`: The league ID to filter the data by.
    - `PerMode`: The mode for per-game stats (e.g., "PerGame", "Totals").
    - `StatCategory`: The category of stats to filter by (e.g., "PTS", "REB").
    - `Season`: The season to filter the data by (e.g., "2022-23").
    - `SeasonType`: The type of season (e.g., "Regular Season", "Playoffs").
    - `Scope`: The scope of the data (e.g., "All", "Home", "Away").
    - `ActiveFlag`: A flag to indicate if only active players should be included.
  - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).
  ## Example
      iex> NBA.Stats.LeagueLeadersGrids.get()
      {:ok, [%{"PLAYER_ID" => 2544, ...}, ...]}
  ## Returns
  - `{:ok, leaders}`: A map of all-time leaders data.
  - `{:error, reason}`: An error tuple with the reason for failure.
  ## Notes
  - For All-Time Leaders, the `Season` parameter can be set to "All Time".
  """
  @spec get(keyword(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(
        params \\ [
          LeagueID: "00",
          PerMode: "Totals",
          StatCategory: "PTS",
          Season: "All Time",
          SeasonType: "Regular Season",
          Scope: "S",
          ActiveFlag: "No"
        ],
        opts \\ []
      )

  def get(params, opts) when is_list(opts) do
    NBA.API.Stats.get(@endpoint, params, opts)
    |> parse_leaders()
  end

  def get(_params, _opts) do
    {:error, "Invalid options: must be a keyword list"}
  end

  defp parse_leaders({:ok, %{data: data}}), do: {:ok, data}
  defp parse_leaders({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}
  defp parse_leaders({:error, _} = err), do: err
  defp parse_leaders(other), do: {:error, {:unexpected, other}}
end
