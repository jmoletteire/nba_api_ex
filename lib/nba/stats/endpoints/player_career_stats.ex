defmodule NBA.Stats.PlayerCareerStats do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerCareerStats.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playercareerstats"

  @accepted_types %{
    PerMode: [:string],
    PlayerID: [:integer, :string],
    LeagueID: [:string]
  }

  @default [
    PerMode: "Totals",
    PlayerID: nil,
    LeagueID: "00"
  ]

  @required [:PlayerID]

  @doc """
  Fetches PlayerCareerStats data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer | String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `"Totals"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
        - `"Per36"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String | nil`
      - _Example_: `LeagueID: "00"`
      - _Default_: `nil`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerCareerStats.get(PerMode: "Totals", PlayerID: 201939)
      {:ok, %{"PlayerCareerStats" => [%{...}, ...]}}
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
