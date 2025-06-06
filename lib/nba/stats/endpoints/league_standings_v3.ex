defmodule NBA.Stats.LeagueStandingsV3 do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league standings v3.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguestandingsv3"

  @accepted_types %{
    LeagueID: [:string],
    Season: [:string],
    SeasonType: [:string],
    SeasonYear: [:string]
  }

  @default [
    LeagueID: "00",
    SeasonType: "Regular Season",
    SeasonYear: nil
  ]

  @required [:SeasonYear]

  @doc """
  Fetches league standings v3 data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `SeasonYear`: **(Required)** The season year.
      - _Type(s)_: `String`
      - _Example_: `SeasonYear: "2024-25"`
      - _Default_: `nil`
      - _Pattern_: `^\\d{4}-\\d{2}$`

    - `LeagueID`: The league ID (e.g., "00" for NBA).
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueStandingsV3.get(LeagueID: "00", Season: "2024-25", SeasonType: "Regular Season")
      {:ok, %{"LeagueStandingsV3" => [%{...}, ...]}}
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
