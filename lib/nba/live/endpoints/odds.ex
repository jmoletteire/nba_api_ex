defmodule NBA.Live.Odds do
  @moduledoc """
  Fetches live NBA odds data.
  """

  @endpoint "odds/odds_todaysGames.json"

  @accepted_types %{}
  @default []

  @doc """
  Fetches live NBA odds data.

  ## Parameters
    - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
        - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.Live.Odds.get()
      {:ok, [%{"gameId" => "0042400311", ...}, ...]}

  ## Returns
    - `{:ok, odds}`: A map containing the odds data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  def get(opts \\ []) do
    with :ok <- NBA.Utils.validate_input(@default, opts, @accepted_types) do
      case NBA.API.Live.get(@endpoint, @default, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        {:error, %Jason.DecodeError{}} -> {:ok, %{}}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end

  def get!(opts \\ []) do
    case get(opts) do
      {:ok, result} -> result
      {:error, reason} -> raise "Failed to fetch odds data: #{inspect(reason)}"
    end
  end
end
