defmodule NBA.Stats.TeamYearByYearStats do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamYearByYearStats.

  See `get/2` for parameter and usage details.
  """

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamyearbyyearstats"

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    SeasonType: [:string],
    TeamID: [:integer]
  }

  @default [
    LeagueID: "00",
    PerMode: "Totals",
    SeasonType: "Regular Season",
    TeamID: nil
  ]

  @required [:TeamID]

  @doc """
  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `LeagueID`: The league ID (2-digit string).
      - _Type(s)_: `String`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"`
        - `"10"`

    - `PerMode`: The per mode for stats.
      - _Type(s)_: `String`
      - _Default_: `"Totals"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamYearByYearStats.get(TeamID: 1610612744)
      {:ok, %{"TeamYearByYearStats" => [%{...}, ...]}}
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
