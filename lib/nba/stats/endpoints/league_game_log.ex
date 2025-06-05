defmodule NBA.Stats.LeagueGameLog do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league game logs.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguegamelog"

  @accepted_types %{
    Counter: [:integer],
    DateFrom: [:string],
    DateTo: [:string],
    Direction: [:string],
    LeagueID: [:string],
    PlayerOrTeam: [:string],
    Season: [:string],
    SeasonType: [:string],
    Sorter: [:string]
  }

  @default [
    Counter: 1000,
    Direction: "DESC",
    LeagueID: "00",
    PlayerOrTeam: "P",
    Season: nil,
    SeasonType: "Regular Season",
    Sorter: "DATE",
    DateFrom: nil,
    DateTo: nil
  ]

  @required [:Season]

  @doc """
  Fetches league game log data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `Counter`: The number of records to return (default: 1000).
      - _Type(s)_: `Integer`
      - _Example_: `Counter: 1000`
      - _Default_: `1000`

    - `Direction`: The sort direction.
      - _Type(s)_: `String`
      - _Example_: `Direction: "DESC"`
      - _Default_: `"DESC"`
      - _Valueset_:
        - "ASC"
        - "DESC"

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`

    - `PlayerOrTeam`: Whether to return player or team logs.
      - _Type(s)_: `String`
      - _Example_: `PlayerOrTeam: "P"`
      - _Default_: `"P"`
      - _Valueset_:
        - "P" (Player)
        - "T" (Team)

    - `Season`: The season for which to fetch data.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - "Regular Season"
        - "Pre Season"
        - "Playoffs"
        - "All Star"
        - "All-Star"

    - `Sorter`: The stat or field to sort by.
      - _Type(s)_: `String`
      - _Example_: `Sorter: "DATE"`
      - _Default_: `"DATE"`
      - _Valueset_:
        - `"FGM"`
        - `"FGA"`
        - `"FG_PCT"`
        - `"FG3M"`
        - `"FG3A"`
        - `"FG3_PCT"`
        - `"FTM"`
        - `"FTA"`
        - `"FT_PCT"`
        - `"OREB"`
        - `"DREB"`
        - `"AST"`
        - `"STL"`
        - `"BLK"`
        - `"TOV"`
        - `"REB"`
        - `"PTS"`
        - `"DATE"`

    - `DateFrom`: Start date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "01/01/2024"`
      - _Default_: `nil`

    - `DateTo`: End date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateTo: "01/31/2024"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueGameLog.get(Season: "2024-25", PlayerOrTeam: "P")
      {:ok, %{"LeagueGameLog" => [%{...}, ...]}}
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
