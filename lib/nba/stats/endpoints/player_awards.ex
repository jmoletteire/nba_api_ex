defmodule NBA.Stats.PlayerAwards do
  @moduledoc """
  Fetches award data for a specific NBA player.

  ## Example

      NBA.PlayerAwards.get(PlayerID: "2544")
      {:ok,
       %{
         "All-NBA" => [
           %{
               "ALL_NBA_TEAM_NUMBER" => "1",
               "CONFERENCE" => "West",
               "DESCRIPTION" => "All-NBA",
               "SEASON" => "2019-20",
               "TYPE" => "Award"
             },
             %{
               "ALL_NBA_TEAM_NUMBER" => "2",
               "CONFERENCE" => "West",
               "DESCRIPTION" => "All-NBA",
               "SEASON" => "2020-21",
               "TYPE" => "Award"
             },
         ]
       }}
  ## Notes
  - The `DESCRIPTION` field is used as the key for the awards map.
  - The `ALL_NBA_TEAM_NUMBER` field indicates the team number for All-NBA awards.
  - The `SEASON` field indicates the season in which the award was received.
  - The `CONFERENCE` field indicates the conference for the award.
  - The `TYPE` field indicates the type of award.
  """

  alias NBA.Utils, as: Util

  @endpoint "playerawards"
  @keys ~w(DESCRIPTION ALL_NBA_TEAM_NUMBER SEASON CONFERENCE TYPE)

  @doc """
  Fetches awards for a specific player.
  ## Parameters
  - `params`: A keyword list of parameters for the request.
    - `PlayerID`: The ID of the player to fetch awards for.
  - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).
  ## Example
      iex> NBA.Stats.PlayerAwards.get(PlayerID: "2544")
      {:ok, %{"All-NBA" => [%{"DESCRIPTION" => "All-NBA", ...}]}}
  ## Returns
  - `{:ok, awards}`: A map of awards grouped by award name.
  - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(keyword(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(params, opts \\ [])

  def get(params, opts) do
    with :ok <- validate_input(params, opts) do
      # PlayerAwards expects PlayerID to be an integer
      player_id = Util.integer_id(Keyword.get(params, :PlayerID))
      params = Keyword.put(params, :PlayerID, player_id)

      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: %{"PlayerAwards" => awards}}} ->
          Enum.group_by(awards, &Map.get(&1, "DESCRIPTION", "UNKNOWN"), fn award ->
            Map.take(award, @keys)
          end)
          |> then(&{:ok, &1})

        {:error, %Jason.DecodeError{}} ->
          {:error, :decode_error}

        {:error, _} = err ->
          err

        other ->
          {:error, {:unexpected, other}}
      end
    else
      {:error, :invalid_params} ->
        {:error, "Invalid parameters: must be a keyword list"}

      {:error, :invalid_opts} ->
        {:error, "Invalid options: must be a keyword list"}

      {:error, :missing_player_id} ->
        {:error, "Missing required parameter: PlayerID"}

      {:error, :invalid_player_id} ->
        {:error, "Invalid PlayerID: must be an integer or numeric string"}

      {:error, _} = err ->
        err

      other ->
        {:error, {:unexpected, other}}
    end
  end

  defp validate_input(params, opts) do
    cond do
      not is_list(params) ->
        {:error, :invalid_params}

      not is_list(opts) ->
        {:error, :invalid_opts}

      not Keyword.has_key?(params, :PlayerID) ->
        {:error, :missing_player_id}

      not Util.valid_id?(Keyword.get(params, :PlayerID)) ->
        {:error, :invalid_player_id}

      true ->
        :ok
    end
  end
end
