defmodule NBA.Stats.CommonTeamRoster do
  @moduledoc """
  Fetches the roster for a specific NBA team.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "commonteamroster"

  @accepted_types %{
    TeamID: [:integer, :string],
    Season: [:string],
    LeagueID: [:string]
  }

  @default [LeagueID: "00"]

  @required [:TeamID, :Season]

  @doc """
  Fetches the roster for a specific NBA team.
  This function retrieves the roster details based on the provided parameters.
  ## Parameters
  - `params`: A keyword list of parameters to filter the team roster.
    - `TeamID`: **(Required)** The unique identifier for the team.
      - _Type(s)_: `Integer`, Numeric `String`.
      - _Example_: `TeamID: 1610612747` (for Los Angeles Lakers).
    - `Season`: **(Required)** The season for which to retrieve the roster.
      - _Type(s)_: `String`.
      - _Example_: `Season: "2022-23"`.
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
      iex> NBA.Stats.CommonTeamRoster.get(TeamID: 1610612747, Season: "2022-23")
      {:ok, %{"Coaches" => [%{...}, ...], "CommonTeamRoster" => [%{"PlayerID" => 237, "FirstName" => "LeBron", "LastName" => "James", ...}, ...]}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         team_id <- NBA.Utils.integer_id(Keyword.get(params, :TeamID)) do
      params =
        Keyword.merge(@default, params)
        |> Keyword.put_new(:TeamID, team_id)

      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
