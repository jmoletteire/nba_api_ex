defmodule NBA.Live.BoxScore do
  @moduledoc """
  Fetches boxscore data for a specific NBA game.
  """

  @endpoint "boxscore/boxscore_"

  @doc """
  Fetches boxscore data for a specific game.
  ## Parameters
  - `game_id`: The ID of the game to fetch boxscore data for.
  - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).
  ## Example
      iex> NBA.Live.BoxScore.get("0042400311")
      {:ok, %{"gameId" => "0042400311", ...}}
  ## Notes
  - The `game_id` should be a string representing the game ID.
  ## Returns
  - `{:ok, boxscore}`: A map containing the boxscore data for the game.
  - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(String.t(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(game_id, opts \\ [])

  def get(game_id, opts) when is_binary(game_id) do
    NBA.API.Live.get(@endpoint <> game_id <> ".json", [], opts)
    |> parse_response()
  end

  def get(game_id, _opts) when is_integer(game_id) do
    get(Integer.to_string(game_id))
  end

  def get(_game_id, _opts) do
    {:error, "Invalid game_id: must be a string or numeric string"}
  end

  defp parse_response({:ok, %{data: data}}), do: {:ok, data}
  defp parse_response({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}

  # Nonexistent game IDs return 403 Forbidden
  # In this case, we return an empty map
  defp parse_response(
         {:error, "Forbidden (403). You may be blocked or missing required headers."}
       ),
       do: {:ok, %{}}

  defp parse_response({:error, _} = err), do: err
  defp parse_response(other), do: {:error, {:unexpected, other}}
end
