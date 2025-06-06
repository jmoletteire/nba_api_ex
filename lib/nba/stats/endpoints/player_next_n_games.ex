defmodule NBA.Stats.PlayerNextNGames do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerNextNGames.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playernextngames"

  @accepted_types %{
    NumberOfGames: [:integer],
    PlayerID: [:integer, :string],
    Season: [:string],
    SeasonType: [:string],
    LeagueID: [:string]
  }

  @default [
    NumberOfGames: 5,
    PlayerID: nil,
    Season: nil,
    SeasonType: "Regular Season",
    LeagueID: "00"
  ]

  @required [:PlayerID, :Season]

  @doc """
  Fetches PlayerNextNGames data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`
      - _Pattern_: `^(\\d{4}-\\d{2})|(ALL)$`

    - `NumberOfGames`: The number of upcoming games to return.
      - _Type(s)_: `Integer`
      - _Example_: `NumberOfGames: 5`
      - _Default_: `nil`

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All-Star"`
        - `"All Star"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Pattern_: `^\\d{2}$`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerNextNGames.get(PlayerID: 201939, NumberOfGames: 5, Season: "2024-25", SeasonType: "Regular Season")
      {:ok, %{"PlayerNextNGames" => [%{...}, ...]}}
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
