defmodule NBA.Live.Scoreboard do
  @moduledoc """
  Fetches the NBA scoreboard data for a specific date.
  """

  @endpoint "scoreboard/todaysScoreboard_00.json"

  @doc """
  Fetches live NBA scoreboard data.

  ## Parameters
    - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).

  ## Example
      iex> NBA.Live.Scoreboard.get()
      {:ok, [%{"gameId" => "0042400311", ...}, ...]}

  ## Returns
    - `{:ok, scoreboard}`: A map containing the scoreboard data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(keyword()) :: {:ok, list()} | {:error, any()}
  def get(opts \\ [])

  def get(opts) when is_list(opts) do
    NBA.API.Live.get(@endpoint, opts)
    |> parse_scoreboard()
  end

  def get(_opts) do
    {:error, "Invalid options: must be a keyword list"}
  end

  defp parse_scoreboard({:ok, %{data: data}}), do: {:ok, Map.get(data, "games", [])}
  defp parse_scoreboard({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}
  defp parse_scoreboard({:error, _} = err), do: err
  defp parse_scoreboard(other), do: {:error, {:unexpected, other}}
end
