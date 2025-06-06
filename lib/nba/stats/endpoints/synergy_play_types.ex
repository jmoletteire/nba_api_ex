defmodule NBA.Stats.SynergyPlayTypes do
  @moduledoc """
  Provides functions to interact with the NBA stats API for SynergyPlayTypes.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "synergyplaytypes"

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    PlayerOrTeam: [:string],
    SeasonType: [:string],
    SeasonYear: [:string],
    TypeGrouping: [:string],
    PlayType: [:string]
  }

  @default [
    LeagueID: "00",
    PerMode: "PerGame",
    PlayerOrTeam: "P",
    SeasonType: "Regular Season",
    SeasonYear: nil,
    TypeGrouping: nil,
    PlayType: nil
  ]

  @required [
    :SeasonYear
  ]

  @doc """
  Fetches SynergyPlayTypes data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `PerMode`: **(Required)** The data aggregation mode.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`

    - `PlayerOrTeam`: **(Required)** Whether to return player or team data.
      - _Type(s)_: `String`
      - _Example_: `PlayerOrTeam: "P"`
      - _Default_: `nil`
      - _Valueset_:
        - `"P"`
        - `"T"`

    - `SeasonType`: **(Required)** The season type.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`
        - `"All-Star"`

    - `SeasonYear`: **(Required)** The season year.
      - _Type(s)_: `String`
      - _Example_: `SeasonYear: "2024-25"`
      - _Default_: `nil`

    - `LeagueID`: The league ID. Defaults to `"00"` (NBA). Not required.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`

    - `TypeGrouping`: The type grouping.
      - _Type(s)_: `String`
      - _Example_: `TypeGrouping: "Offensive"`
      - _Default_: `nil`

    - `PlayType`: The play type.
      - _Type(s)_: `String`
      - _Example_: `PlayType: "Transition"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.SynergyPlayTypes.get(PerMode: "PerGame", PlayerOrTeam: "P", SeasonType: "Regular Season", SeasonYear: "2024-25")
      {:ok, %{"SynergyPlayTypes" => [%{...}, ...]}}
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
