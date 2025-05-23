defmodule NBA.Live.Odds do
  @moduledoc """
  Fetches live NBA odds data.
  """

  @endpoint "odds/odds_todaysGames.json"

  @doc """
  Fetches live NBA odds data.

  ## Parameters
    - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).

  ## Example
      iex> NBA.Live.Odds.get()
      {:ok, [%{"gameId" => "0042400311", ...}, ...]}

  ## Returns
    - `{:ok, odds}`: A map containing the odds data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(keyword()) :: {:ok, list()} | {:error, any()}
  def get(opts \\ [])

  def get(opts) when is_list(opts) do
    NBA.API.Live.get(@endpoint, opts)
    |> parse_odds()
  end

  def get(_opts) do
    {:error, "Invalid options: must be a keyword list"}
  end

  defp parse_odds({:ok, %{data: data}}), do: {:ok, data}
  defp parse_odds({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}
  defp parse_odds({:error, _} = err), do: err
  defp parse_odds(other), do: {:error, {:unexpected, other}}
end
