defmodule NBA.Stats.PlayerGameLog do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerGameLog.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playergamelog"

  @accepted_types %{
    PlayerID: [:integer, :string],
    Season: [:string],
    SeasonType: [:string],
    LeagueID: [:string],
    DateTo: [:string],
    DateFrom: [:string]
  }

  @default [
    PlayerID: nil,
    Season: nil,
    SeasonType: "Regular Season",
    LeagueID: "00",
    DateTo: nil,
    DateFrom: nil
  ]

  @required [:PlayerID, :Season]

  @doc """
  Fetches PlayerGameLog data.

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

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
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
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

    - `DateTo`: The end date.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "01/31/2025"`
      - _Default_: `nil`

    - `DateFrom`: The start date.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "01/01/2025"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerGameLog.get(PlayerID: 201939, Season: "2024-25")
      {:ok, %{"PlayerGameLog" => [%{...}, ...]}}
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
