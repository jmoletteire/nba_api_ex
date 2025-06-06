defmodule NBA.Stats.DraftHistory do
  @moduledoc """
  Provides access to the NBA Draft History endpoint.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "drafthistory"

  @accepted_types %{
    LeagueID: [:string],
    TopX: [:integer],
    TeamID: [:integer, :string],
    Season: [:string],
    RoundPick: [:integer],
    RoundNum: [:integer],
    OverallPick: [:integer],
    College: [:string]
  }

  @default [LeagueID: "00"]

  @doc """
  Fetches the NBA Draft History data.
  ## Parameters
  - `params`: A keyword list of parameters to filter the draft history.
    - `LeagueID`: The league ID (default: "00" for NBA).
    - `TopX`: Limit results to top X picks.
    - `TeamID`: Filter by team ID (integer or string).
    - `Season`: The season to filter by (e.g., "2022-23").
    - `RoundPick`: Filter by round pick number.
    - `RoundNum`: Filter by round number.
    - `OverallPick`: Filter by overall pick number.
    - `College`: Filter by college name.

  ## Returns
  - `{:ok, data}`: A tuple containing the draft history data.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.DraftHistory.get(Season: "2022")
      {:ok, [%{"LeagueID" => "00", "Season" => "2022", ...}]}
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
