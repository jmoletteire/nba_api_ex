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

  def get(params, opts) when is_list(params) and is_list(opts) do
    with :ok <- validate_params(params),
         {:ok, player_id} when is_binary(player_id) <- Keyword.fetch(params, :PlayerID) do
      NBA.API.Stats.get(@endpoint, params, opts)
      |> parse_awards()
    else
      {:ok, other} ->
        {:error, "Invalid :PlayerID — expected an string, got: #{inspect(other)}"}

      :error ->
        {:error, "Missing required parameter :PlayerID"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get(params, _opts) when not is_list(params) do
    {:error, "Invalid parameters: must be a keyword list"}
  end

  def get(_params, opts) when not is_list(opts) do
    {:error, "Invalid options: must be a keyword list"}
  end

  def get(_params, _opts) do
    {:error, "Invalid args: check your input and try again"}
  end

  defp validate_params(params) do
    Enum.reduce_while(params, :ok, fn
      {:PlayerID, val}, :ok when is_binary(val) -> {:cont, :ok}
      {:PlayerID, val}, _ -> {:halt, {:error, "Invalid PlayerID: #{inspect(val)}"}}
      _, acc -> {:cont, acc}
    end)
  end

  # Parses the response from the NBA API.
  # It groups the awards by their description and returns a map.
  # The map contains the award description as the key and a list
  # of awards as the value.
  # Each award is represented as a map with relevant fields.
  # If the response is not in the expected format, it returns an error.
  #
  # - `Enum.group_by/3` groups the awards by their description.
  #    If the description is not found, it defaults to "UNKNOWN".
  # - `Map.take/2` extracts only the relevant fields for each award.
  # - `then/2` transforms the data into the desired format.
  #
  defp parse_awards({:ok, %{data: data}}) do
    data
    |> Enum.group_by(&Map.get(&1, "DESCRIPTION", "UNKNOWN"), fn award ->
      Map.take(award, @keys)
    end)
    |> then(&{:ok, &1})
  end

  defp parse_awards({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}
  defp parse_awards({:error, _} = err), do: err
  defp parse_awards(other), do: {:error, {:unexpected, other}}
end
