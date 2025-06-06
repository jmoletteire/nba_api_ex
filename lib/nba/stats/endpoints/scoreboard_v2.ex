defmodule NBA.Stats.ScoreboardV2 do
  @moduledoc """
  Provides functions to interact with the NBA stats API for ScoreboardV2.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "scoreboardv2"

  @accepted_types %{
    DayOffset: [:integer, :string],
    GameDate: [:string],
    LeagueID: [:string]
  }

  @default [
    DayOffset: 0,
    GameDate: nil,
    LeagueID: "00"
  ]

  @required [:GameDate]

  @doc """
  Fetches ScoreboardV2 data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `GameDate`: **(Required)** The game date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Example_: `GameDate: "2025-03-01"`
      - _Default_: `nil`

    - `DayOffset`: The day offset (can be negative or positive integer).
      - _Type(s)_: `Integer` | `String`
      - _Example_: `DayOffset: 0`
      - _Default_: `0`
      - _Pattern_: `^-{0,1}\d+$`

    - `LeagueID`: The league ID. Defaults to `"00"` (NBA). Not required.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Pattern_: `^\d{2}$`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.ScoreboardV2.get(GameDate: "2025-03-01")
      {:ok, %{"ScoreboardV2" => [%{...}, ...]}}
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
