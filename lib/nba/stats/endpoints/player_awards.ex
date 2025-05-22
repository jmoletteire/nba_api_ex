defmodule NBA.Stats.PlayerAwards do
  @moduledoc """
  Fetches award data for a specific NBA player.

  ## Example

      NBA.PlayerAwards.get(2544)
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
  - `player_id`: The ID of the player to fetch awards for.
  - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).
  ## Example
      iex> NBA.Stats.PlayerAwards.get(2544)
      {:ok, %{"All-NBA" => [%{"DESCRIPTION" => "All-NBA", ...}]}}
  ## Notes
  - The `player_id` can be an integer or a string that can be parsed to an integer.
  ## Returns
  - `{:ok, awards}`: A map of awards grouped by award name.
  - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(integer() | binary(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(player_id, opts \\ [])

  def get(player_id, opts) when is_integer(player_id) do
    NBA.API.Stats.get(@endpoint, [PlayerID: player_id], opts)
    |> parse_awards()
  end

  def get(player_id, opts) when is_binary(player_id) do
    case Integer.parse(player_id) do
      {int_id, _} -> get(int_id, opts)
      :error -> {:error, "Invalid player_id: must be an integer or numeric string"}
    end
  end

  def get(_, _), do: {:error, "Invalid player_id: must be an integer or numeric string"}

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
