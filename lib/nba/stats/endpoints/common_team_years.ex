defmodule NBA.Stats.CommonTeamYears do
  @moduledoc """
  Fetches the years a team has played in the NBA.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "commonteamyears"

  @accepted_types %{
    LeagueID: [:string]
  }

  @default [LeagueID: "00"]

  @doc """
  This function retrieves the years a team has participated in the league based on the provided parameters.

  ## Parameters
  - `params`: A keyword list of parameters to filter the team years.
    - `LeagueID`: The league ID.
      - _Type(s)_: Numeric `String`.
      - _Default_: `"00"` (NBA).
      - _Example_: `LeagueID: "10"` (for WNBA).
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.CommonTeamYears.get()
      {:ok, [%{"TeamID" => 1610612737, "Year" => "1946-47"}, ...]}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: %{"TeamYears" => team_years}}} -> {:ok, team_years}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
