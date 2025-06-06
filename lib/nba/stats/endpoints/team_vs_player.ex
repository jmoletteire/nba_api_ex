defmodule NBA.Stats.TeamVsPlayer do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamVsPlayer.

  See `get/2` for parameter and usage details.
  """

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamvsplayer"

  @accepted_types %{
    LastNGames: [:integer],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer],
    VsPlayerID: [:integer],
    VsDivision: [:string],
    VsConference: [:string],
    SeasonSegment: [:string],
    PlayerID: [:integer],
    Outcome: [:string],
    Location: [:string],
    LeagueID: [:string],
    GameSegment: [:string],
    DateTo: [:string],
    DateFrom: [:string]
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
    TeamID: 0,
    VsPlayerID: 0,
    VsDivision: "",
    VsConference: "",
    SeasonSegment: "",
    PlayerID: 0,
    Outcome: "",
    Location: "",
    LeagueID: "00",
    GameSegment: "",
    DateTo: "",
    DateFrom: ""
  ]

  @required [:Season]

  @doc """
  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LastNGames`: The number of last games to include.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `MeasureType`: The measure type for detailed defense.
      - _Type(s)_: `String`
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

    - `Month`: The month of the season.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `OpponentTeamID`: The opposing team ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `PaceAdjust`: Whether to adjust for pace.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `PerMode`: The per mode for detailed stats.
      - _Type(s)_: `String`
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

    - `Period`: The period of the game.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `PlusMinus`: Whether to include plus/minus data.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Rank`: Whether to include rank data.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Season`: The NBA season.
      - _Type(s)_: `String`
      - _Default_: `"2024-25"`

    - `SeasonType`: The season type for playoffs.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`

    - `TeamID`: The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `VsPlayerID`: The opposing player ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `VsDivision`: The opposing division.
      - _Type(s)_: `String`
      - _Default_: `""`
      - _Valueset_:
        - `"Atlantic"`
        - `"Central"`
        - `"Northwest"`
        - `"Pacific"`
        - `"Southeast"`
        - `"Southwest"`
        - `"East"`
        - `"West"`

    - `VsConference`: The opposing conference.
      - _Type(s)_: `String`
      - _Default_: `""`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Default_: `""`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `PlayerID`: The player ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `Outcome`: The game outcome.
      - _Type(s)_: `String`
      - _Default_: `""`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `Location`: The game location.
      - _Type(s)_: `String`
      - _Default_: `""`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"`

    - `GameSegment`: The game segment.
      - _Type(s)_: `String`
      - _Default_: `""`
      - _Valueset_:
        - `"First Half"`
        - `"Overtime"`
        - `"Second Half"`

    - `DateTo`: The end date for filtering games.
      - _Type(s)_: `String`
      - _Default_: `""`

    - `DateFrom`: The start date for filtering games.
      - _Type(s)_: `String`
      - _Default_: `""`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamVsPlayer.get(TeamID: 1610612744, VsPlayerID: 201939)
      {:ok, %{"TeamVsPlayer" => [%{...}, ...]}}
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
