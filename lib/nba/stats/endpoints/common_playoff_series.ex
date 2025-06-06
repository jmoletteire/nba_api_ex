defmodule NBA.Stats.CommonPlayoffSeries do
  @moduledoc """
  Handles requests to the NBA Stats API for common playoff series data.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "commonplayoffseries"

  @accepted_types %{
    LeagueID: [:string],
    Season: [:string],
    SeriesID: [:string]
  }

  @default [LeagueID: "00"]

  @required [:Season]

  @doc """
  Fetches common playoff series data from the NBA Stats API.

  ## Parameters
  - `params`: Keyword list of parameters for the request.
    - `LeagueID`: The league ID (default is "00" for NBA).
      - _Type_: String.
      - _Example_: `LeagueID: "00"`.
    - `Season`: **(Required)** The season to filter by (e.g., "2022-23").
      - _Type_: String.
      - _Example_: `Season: "2022-23"`.
    - `SeriesID`: Optional series ID to filter specific playoff series.
      - _Type_: String.
      - _Example_: `SeriesID: "12345"`.
  - `opts`: Additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.CommonPlayoffSeries.get(Season: "2022-23")
      {:ok, %{"resultSets" => [%{"rowSet" => rows, "headers" => headers}]}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: %{"PlayoffSeries" => playoffs}}} -> {:ok, playoffs}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
