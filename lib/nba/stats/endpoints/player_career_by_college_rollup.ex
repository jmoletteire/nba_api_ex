defmodule NBA.Stats.PlayerCareerByCollegeRollup do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerCareerByCollegeRollup.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playercareerbycollegerollup"

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    SeasonType: [:string],
    Season: [:string]
  }

  @default [
    LeagueID: "00",
    PerMode: "Totals",
    SeasonType: "Regular Season",
    Season: nil
  ]

  @required []

  @doc """
  Fetches PlayerCareerByCollegeRollup data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `"Totals"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

    - `Season`: Specific season to fetch data for.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerCareerByCollegeRollup.get(LeagueID: "00", PerMode: "Totals", SeasonType: "Regular Season")
      {:ok, %{"PlayerCareerByCollegeRollup" => [%{...}, ...]}}
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
