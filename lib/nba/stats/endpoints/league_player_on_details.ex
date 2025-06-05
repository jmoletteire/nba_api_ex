defmodule NBA.Stats.LeaguePlayerOnDetails do
  @moduledoc """
  Provides functions to interact with the NBA stats API for league player on details.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "leagueplayerondetails"

  @accepted_types %{
    DateFrom: [:string],
    DateTo: [:string],
    GameSegment: [:string],
    LastNGames: [:integer],
    LeagueID: [:string],
    Location: [:string],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    Outcome: [:string],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonSegment: [:string],
    SeasonType: [:string],
    TeamID: [:integer, :string],
    VsConference: [:string],
    VsDivision: [:string]
  }

  @default [
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "N",
    Rank: "N",
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    SeasonSegment: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: nil,
    GameSegment: nil,
    DateTo: nil,
    DateFrom: nil
  ]

  @required [:Season, :TeamID]

  @doc """
  Fetches league player on details data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LastNGames`: Number of most recent games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 0`
      - _Default_: `0`

    - `MeasureType`: The type of measure to return.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `"Base"`
      - _Valueset_:
        - `"Base"`
        - `"Advanced"`
        - `"Misc"`
        - `"Four Factors"`
        - `"Scoring"`
        - `"Opponent"`
        - `"Usage"`
        - `"Defense"`

    - `Month`: Month filter.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 0`
      - _Default_: `0`

    - `OpponentTeamID`: Opponent team ID filter.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `OpponentTeamID: 0`
      - _Default_: `0`

    - `PaceAdjust`: Whether to adjust stats for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `PerMode`: How stats are aggregated.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
        - `"MinutesPer"`
        - `"Per48"`
        - `"Per40"`
        - `"Per36"`
        - `"PerMinute"`
        - `"PerPossession"`
        - `"PerPlay"`
        - `"Per100Possessions"`
        - `"Per100Plays"`

    - `Period`: Period filter.
      - _Type(s)_: `Integer`
      - _Example_: `Period: 0`
      - _Default_: `0`

    - `PlusMinus`: Whether to include plus/minus splits.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Rank`: Whether to include team rank.
      - _Type(s)_: `String`
      - _Example_: `Rank: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

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

    - `TeamID`: **(Required)** Team ID filter.
      - _Type(s)_: `Integer` or `String`
      - _Example_: `TeamID: 1610612747`
      - _Default_: `nil`

    - `VsDivision`: Opponent division filter (e.g., "Atlantic", "Central", etc.).
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Pacific"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Atlantic"`
        - `"Central"`
        - `"Northwest"`
        - `"Pacific"`
        - `"Southeast"`
        - `"Southwest"`
        - `"East"`
        - `"West"`

    - `VsConference`: Opponent conference filter ("East", "West").
      - _Type(s)_: `String`
      - _Example_: `VsConference: "West"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `SeasonSegment`: Season segment filter ("Post All-Star", "Pre All-Star").
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Post All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `Outcome`: Game outcome filter ("W", "L").
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `Location`: Game location filter ("Home", "Road").
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `LeagueID`: League ID filter.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `nil`

    - `GameSegment`: Game segment filter (e.g., "First Half", "Second Half", "Overtime").
      - _Type(s)_: `String`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Second Half"`
        - `"Overtime"`

    - `DateTo`: End date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateTo: "01/31/2024"`
      - _Default_: `nil`

    - `DateFrom`: Start date filter (format: "MM/DD/YYYY").
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "01/01/2024"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.LeaguePlayerOnDetails.get(Season: "2024-25", TeamID: 1610612747)
      {:ok, %{"LeaguePlayerOnDetails" => [%{...}, ...]}}
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
