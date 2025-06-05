defmodule NBA.Stats.MatchupsRollup do
  @moduledoc """
  Provides functions to interact with the NBA stats API for MatchupsRollup.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "matchupsrollup"

  @accepted_types %{
    LeagueID: [:string],
    PerMode: [:string],
    Season: [:string],
    SeasonType: [:string],
    OffTeamID: [:integer, :string],
    OffPlayerID: [:integer, :string],
    DefTeamID: [:integer, :string],
    DefPlayerID: [:integer, :string]
  }

  @default [
    LeagueID: "00",
    PerMode: "Totals",
    Season: nil,
    SeasonType: "Regular Season",
    OffTeamID: nil,
    OffPlayerID: nil,
    DefTeamID: nil,
    DefPlayerID: nil
  ]

  @required [:Season]

  @doc """
  Fetches MatchupsRollup data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `Season`: **(Required)** The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`
      - _Pattern_: `^(\\d{4}-\\d{2})$`

    - `DefPlayerID`: Defensive player ID.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `DefPlayerID: 1629029`
      - _Default_: `nil`

    - `DefTeamID`: Defensive team ID.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `DefTeamID: 1610612737`
      - _Default_: `nil`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

    - `OffPlayerID`: Offensive player ID.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OffPlayerID: 1629029`
      - _Default_: `nil`

    - `OffTeamID`: Offensive team ID.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OffTeamID: 1610612737`
      - _Default_: `nil`

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `nil`
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
        - `"Pre-Season"`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.MatchupsRollup.get(LeagueID: "00", PerMode: "Totals", Season: "2024-25", SeasonType: "Regular Season")
      {:ok, %{"MatchupsRollup" => [%{...}, ...]}}
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
