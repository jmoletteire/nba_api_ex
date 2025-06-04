defmodule NBA.Stats.ISTStandings do
  @moduledoc """
  Fetches NBA Cup standings data.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "iststandings"

  @accepted_types %{
    LeagueID: [:string],
    Season: [:string],
    Section: [:string]
  }

  @default [
    LeagueID: "00",
    Section: "group"
  ]

  @required [:Season]

  @doc """
  Fetches NBA Cup standings data.

  ## Parameters
    - `params`: A keyword list of parameters, including:
      - `LeagueID`: The league ID.
        - _Type(s)_: Numeric `String`.
        - _Default_: `"00"` (NBA).
        - _Example_: `LeagueID: "10"` (for WNBA).
        - _Valueset_:
          - `"00"` (NBA)
          - `"01"` (ABA)
          - `"10"` (WNBA)
          - `"20"` (G-League)
      - `Season`: **(Required)** The season for which to fetch standings.
        - _Type(s)_: Numeric `String`.
        - _Default_: `"2023-24"` (current season).
        - _Example_: `Season: "2022-23"` (for the previous season).
      - `Section`: The type of season (default is "group").
        - _Type(s)_: `String`.
        - _Default_: `"group"` (for group standings).
        - _Example_: `Section: "wildcard"`
        - _Valueset_:
          - `"group"` (Group standings)
          - `"wildcard"` (Wildcard standings)
    - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
    - `{:ok, data}`: On success, returns a map containing the IST standings data.
    - `{:error, reason}`: On failure, returns an error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.ISTStandings.get(Season: "2023-24")
      {:ok, %{"leagueId" => "00", "seasonYear" => "2023-24", "teams" => [...]}}
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
