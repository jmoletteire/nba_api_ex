defmodule NBA.Stats.LeagueHustleStatsPlayer do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league hustle stats (player).

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leaguehustlestatsplayer"

  @accepted_types %{
    College: [:string],
    Conference: [:string],
    Country: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    Division: [:string],
    DraftPick: [:string],
    DraftYear: [:string],
    Height: [:string],
    LeagueID: [:string],
    Location: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PerMode: [:string],
    PlayerExperience: [:string],
    PlayerPosition: [:string],
    PORound: [:integer],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string],
    Weight: [:string]
  }

  @default [
    PerMode: "PerGame",
    Season: nil,
    SeasonType: "Regular Season",
    Weight: nil,
    VsDivision: nil,
    VsConference: nil,
    TeamID: nil,
    SeasonSegment: nil,
    PlayerPosition: nil,
    PlayerExperience: nil,
    PORound: nil,
    Outcome: nil,
    OpponentTeamID: nil,
    Month: nil,
    Location: nil,
    LeagueID: nil,
    Height: nil,
    DraftYear: nil,
    DraftPick: nil,
    Division: nil,
    DateTo: nil,
    DateFrom: nil,
    Country: nil,
    Conference: nil,
    College: nil
  ]

  @required [:Season]

  @doc """
  Fetches league hustle stats (player) data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
        - `"Per48"`
        - `"Per40"`
        - `"Per36"`
        - `"PerMinute"`

    - `Season`: **(Required)** The season for which to fetch data.
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
        - `"All Star"`

    - `Weight`: Player weight filter.
      - _Type(s)_: `String`
      - _Example_: `Weight: "220"`
      - _Default_: `nil`

    - `VsDivision`: Opponent division filter.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Pacific"`
      - _Default_: `nil`

    - `VsConference`: Opponent conference filter.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "West"`
      - _Default_: `nil`

    - `TeamID`: Team ID filter.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `nil`

    - `SeasonSegment`: Season segment filter.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All-Star"`
      - _Default_: `nil`

    - `PlayerPosition`: Player position filter.
      - _Type(s)_: `String`
      - _Example_: `PlayerPosition: "G"`
      - _Default_: `nil`

    - `PlayerExperience`: Player experience filter.
      - _Type(s)_: `String`
      - _Example_: `PlayerExperience: "Rookie"`
      - _Default_: `nil`

    - `PORound`: Playoff round filter.
      - _Type(s)_: `Integer`
      - _Example_: `PORound: 1`
      - _Default_: `nil`

    - `Outcome`: Game outcome filter.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`

    - `OpponentTeamID`: Opponent team ID filter.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612747`
      - _Default_: `nil`

    - `Month`: Month filter.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `nil`

    - `Location`: Game location filter.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`

    - `LeagueID`: League ID filter.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `nil`

    - `Height`: Player height filter.
      - _Type(s)_: `String`
      - _Example_: `Height: "6-7"`
      - _Default_: `nil`

    - `DraftYear`: Player draft year filter.
      - _Type(s)_: `String`
      - _Example_: `DraftYear: "2015"`
      - _Default_: `nil`

    - `DraftPick`: Player draft pick filter.
      - _Type(s)_: `String`
      - _Example_: `DraftPick: "1"`
      - _Default_: `nil`

    - `Division`: Division filter.
      - _Type(s)_: `String`
      - _Example_: `Division: "Pacific"`
      - _Default_: `nil`

    - `DateTo`: End date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateTo: "01/31/2024"`
      - _Default_: `nil`

    - `DateFrom`: Start date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "01/01/2024"`
      - _Default_: `nil`

    - `Country`: Player country filter.
      - _Type(s)_: `String`
      - _Example_: `Country: "USA"`
      - _Default_: `nil`

    - `Conference`: Conference filter.
      - _Type(s)_: `String`
      - _Example_: `Conference: "West"`
      - _Default_: `nil`

    - `College`: Player college filter.
      - _Type(s)_: `String`
      - _Example_: `College: "Duke"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeagueHustleStatsPlayer.get(Season: "2024-25", PerMode: "PerGame", SeasonType: "Regular Season")
      {:ok, %{"LeagueHustleStatsPlayer" => [%{...}, ...]}}
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
