defmodule NBA.Live.Scoreboard do
  @moduledoc """
  Fetches the NBA scoreboard data for a specific date.
  """

  @endpoint "scoreboard/todaysScoreboard_00.json"

  @accepted_types %{}
  @default []

  @doc """
  Fetches live NBA scoreboard data.

  ## Parameters
    - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
        - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.Live.Scoreboard.get()
      {:ok, [%{"gameId" => "0042400311", ...}, ...]}

  ## Returns
    - `{:ok, scoreboard}`: A map containing the scoreboard data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  def get(opts \\ []) do
    with :ok <- NBA.Utils.validate_input(@default, opts, @accepted_types) do
      case NBA.API.Live.get(@endpoint, @default, opts) do
        {:ok, %{data: %{"games" => games}}} -> {:ok, games}
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
      {:error, reason} -> raise "Failed to fetch scoreboard data: #{inspect(reason)}"
    end
  end
end
