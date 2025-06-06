defmodule NBA.Stats.FranchiseLeaders do
  @moduledoc """
  Fetches franchise leaders data from the NBA stats API.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "franchiseleaders"

  @accepted_types %{TeamID: [:integer, :string], LeagueID: [:string]}
  @default [LeagueID: "00"]
  @required [:TeamID]

  @doc """
  Fetches franchise leaders data for a specific team.
  ## Parameters
    - `params`: A keyword list of parameters for the request.
      - `TeamID`: **(Required)** The team ID.
      - `LeagueID`: The league ID (default: "00" for NBA).
    - `opts`: Additional options for the request, such as headers or timeout settings.

  ## Returns
    - `{:ok, response}`: A map containing the franchise leaders data.
    - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
    iex> NBA.Stats.FranchiseLeaders.get(TeamID: 1610612739)
    {:ok, %{data: [%{"Leader" => "LeBron James", "Value" => 35000}]}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
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
