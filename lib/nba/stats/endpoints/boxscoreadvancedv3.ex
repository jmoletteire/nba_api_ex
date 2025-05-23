defmodule NBA.Stats.BoxScoreAdvancedV3 do
  @moduledoc """
  Fetches advanced box score data for a specific game.
  """

  @endpoint "boxscoreadvancedv3"

  @default [
    LeagueID: "00",
    endPeriod: 0,
    endRange: 31800,
    rangeType: 0,
    startPeriod: 0,
    startRange: 0
  ]

  @doc """
  Fetches advanced box score data for a specific game.

  ## Parameters
    - `game_id`: The ID of the game to fetch data for.
    - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).

  ## Example
      iex> NBA.API.BoxScoreAdvancedV3.get("0022200001")
      {:ok, [%{"gameId" => "0022200001", ...}, ...]}

  ## Returns
    - `{:ok, box_score}`: A map containing the advanced box score data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(keyword(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(params \\ @default, opts \\ [])

  def get(params, opts) when is_list(params) and is_list(opts) do
    with :ok <- validate_param_types(params),
         {:ok, game_id} when is_binary(game_id) <- Keyword.fetch(params, :GameID) do
      final_params = Keyword.merge(@default, params)

      NBA.API.Stats.get(@endpoint, final_params, opts)
      |> parse_box_score()
    else
      {:ok, other} ->
        {:error, "Invalid :GameID — expected a string, got: #{inspect(other)}"}

      :error ->
        {:error, "Missing required parameter :GameID"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get(_game_id, _opts) do
    {:error, "Invalid options: must be a keyword list"}
  end

  defp validate_param_types(params) do
    Enum.reduce_while(params, :ok, fn
      {:GameID, val}, :ok when is_binary(val) -> {:cont, :ok}
      {:LeagueID, val}, :ok when is_binary(val) -> {:cont, :ok}
      {:endPeriod, val}, :ok when is_integer(val) -> {:cont, :ok}
      {:endRange, val}, :ok when is_integer(val) -> {:cont, :ok}
      {:rangeType, val}, :ok when is_integer(val) -> {:cont, :ok}
      {:startPeriod, val}, :ok when is_integer(val) -> {:cont, :ok}
      {:startRange, val}, :ok when is_integer(val) -> {:cont, :ok}
      {key, _val}, _ -> {:halt, {:error, "Invalid type for #{inspect(key)}"}}
    end)
  end

  defp parse_box_score({:ok, %{data: data}}), do: {:ok, Map.get(data, "boxScoreAdvanced", {})}
  defp parse_box_score({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}
  defp parse_box_score({:error, _} = err), do: err
  defp parse_box_score(other), do: {:error, {:unexpected, other}}
end
