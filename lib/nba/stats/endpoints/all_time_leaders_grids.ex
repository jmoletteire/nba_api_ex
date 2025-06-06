defmodule NBA.Stats.AllTimeLeadersGrids do
  @moduledoc """
  Handles requests to the all-time leader grids endpoint.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "alltimeleadersgrids"

  @accepted_types %{
    LeagueID: [:string],
    SeasonType: [:string],
    PerMode: [:string],
    TopX: [:integer]
  }

  @default [
    LeagueID: "00",
    SeasonType: "Regular Season",
    PerMode: "Totals",
    TopX: 10
  ]

  @required []

  @doc """
  Fetches all-time leader grids for the specified league and season type.

  ## Parameters
  - `params`: A keyword list of parameters. Defaults to `@default`.
    - `LeagueID`: The league ID.
      - _Type_: Numeric `String`
      - _Default_: `"00"` (NBA)
      - _Example_: `LeagueID: "10"` (for WNBA).
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)
    - `PerMode`: The statistic mode.
      - _Type_: `String`
      - _Default_: `"Totals"`
      - _Example_: `PerMode: "PerGame"` for per-game statistics.
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
    - `SeasonType`: Type of season.
      - _Type_: `String`
      - _Default_: `"Regular Season"`
      - _Example_: `SeasonType: "Playoffs"` for playoff statistics.
      - _Valueset_:
        - `"Regular Season"`
        - `"Playoffs"`
    - `TopX`: The number of top leaders to return.
      - _Type_: `Integer`
      - _Default_: `10`
      - _Example_: `TopX: 20` to get the top 20 leaders.
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.Stats.AllTimeLeadersGrids.get()
      {:ok, %{"PTSLeaders" => [...], "ASTLeaders" => [...], ...}}

  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.
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
