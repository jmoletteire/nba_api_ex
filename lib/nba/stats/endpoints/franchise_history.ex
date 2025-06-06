defmodule NBA.Stats.FranchiseHistory do
  @moduledoc """
  Fetches franchise history data for every team.
  """

  @moduledoc since: "0.1.0"

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
