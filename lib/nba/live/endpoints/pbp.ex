defmodule NBA.Live.PBP do
  @moduledoc """
  Fetches play-by-play data for a specific NBA game.
  """

  @endpoint "playbyplay/playbyplay_"

  @doc """
  Fetches play-by-play data for a specific game.
  ## Parameters
  - `game_id`: The ID of the game to fetch play-by-play data for.
  - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).
  ## Example
      iex> NBA.Live.PBP.get("0042400311")
      {:ok, %{"gameId" => "0042400311", ...}}
  ## Notes
  - The `game_id` should be a string representing the game ID.
  ## Returns
  - `{:ok, pbp}`: A map containing the play-by-play data for the game.
  - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(String.t(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(game_id, opts \\ [])

  def get(game_id, opts) when is_binary(game_id) do
    NBA.API.Live.get(@endpoint <> game_id <> ".json", [], opts)
    |> parse_pbp()
  end

  def get(game_id, _opts) when is_integer(game_id) do
    get(Integer.to_string(game_id))
  end

  def get(_game_id, _opts) do
    {:error, "Invalid game_id: must be a string or numeric string"}
  end

  defp parse_pbp({:ok, %{data: data}}), do: {:ok, data}
  defp parse_pbp({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}

  # Nonexistent game IDs return 403 Forbidden
  # In this case, we return an empty map
  defp parse_pbp({:error, "Forbidden (403). You may be blocked or missing required headers."}),
    do: {:ok, %{}}

  defp parse_pbp({:error, _} = err), do: err
  defp parse_pbp(other), do: {:error, {:unexpected, other}}
end
