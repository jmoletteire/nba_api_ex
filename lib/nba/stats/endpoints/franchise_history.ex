defmodule NBA.Stats.FranchiseHistory do
  @moduledoc """
  Fetches franchise history data for every team.

  ## Parameters
    - `params`: A keyword list of parameters for the request.
      - `LeagueID`: The league ID (default: "00" for NBA).
      - `SeasonYear`: The season year (required).
      - `opts`: Additional options for the request, such as headers or timeout settings.

  ## Returns
    - `{:ok, response}`: A map containing the franchise history data.
    - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
    iex> NBA.Stats.FranchiseHistory.get(SeasonYear: "2023")
    {:ok, %{data: [%{"FranchiseID" => 1, "FranchiseName" => "Lakers"}]}}
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "franchisehistory"

  @accepted_types %{LeagueID: [:string]}
  @default [LeagueID: "00"]

  @doc """
  Fetches franchise history data for a given season year.
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
