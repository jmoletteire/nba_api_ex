defmodule NBA.Stats.TeamAndPlayersVsPlayers do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamAndPlayersVsPlayers.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamandplayersvsplayers"

  @accepted_types %{
    LastNGames: [:integer],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlayerID1: [:integer, :string],
    PlayerID2: [:integer, :string],
    PlayerID3: [:integer, :string],
    PlayerID4: [:integer, :string],
    PlayerID5: [:integer, :string],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer, :string],
    VsPlayerID1: [:integer, :string],
    VsPlayerID2: [:integer, :string],
    VsPlayerID3: [:integer, :string],
    VsPlayerID4: [:integer, :string],
    VsPlayerID5: [:integer, :string],
    VsTeamID: [:integer, :string],
    VsDivision: [:string],
    VsConference: [:string],
    ShotClockRange: [:string],
    SeasonSegment: [:string],
    Outcome: [:string],
    Location: [:string],
    LeagueID: [:string],
    GameSegment: [:string],
    Division: [:string],
    DateTo: [:string],
    DateFrom: [:string],
    Conference: [:string]
  }

  @default [
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerID1: nil,
    PlayerID2: nil,
    PlayerID3: nil,
    PlayerID4: nil,
    PlayerID5: nil,
    PlusMinus: "N",
    Rank: "N",
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    VsPlayerID1: nil,
    VsPlayerID2: nil,
    VsPlayerID3: nil,
    VsPlayerID4: nil,
    VsPlayerID5: nil,
    VsTeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    ShotClockRange: nil,
    SeasonSegment: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: "00",
    GameSegment: nil,
    Division: nil,
    DateTo: nil,
    DateFrom: nil,
    Conference: nil
  ]

  @required [
    :PlayerID1,
    :PlayerID2,
    :PlayerID3,
    :PlayerID4,
    :PlayerID5,
    :Season,
    :TeamID,
    :VsPlayerID1,
    :VsPlayerID2,
    :VsPlayerID3,
    :VsPlayerID4,
    :VsPlayerID5,
    :VsTeamID
  ]

  @doc """
  Fetches TeamAndPlayersVsPlayers data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LastNGames`: **(Required)** Number of last games to include.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `MeasureType`: **(Required)** The measure type.
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

    - `Month`: **(Required)** The month (1-12, 0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `OpponentTeamID`: **(Required)** The opponent team ID.
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `PaceAdjust`: **(Required)** Whether to adjust for pace.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `PerMode`: **(Required)** The per mode.
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

    - `Period`: **(Required)** The period (0 for all).
      - _Type(s)_: `Integer`
      - _Default_: `0`

    - `PlayerID1`: **(Required)** The first player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `PlayerID2`: **(Required)** The second player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `PlayerID3`: **(Required)** The third player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `PlayerID4`: **(Required)** The fourth player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `PlayerID5`: **(Required)** The fifth player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `PlusMinus`: **(Required)** Whether to include plus/minus.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Rank`: **(Required)** Whether to include rank.
      - _Type(s)_: `String`
      - _Default_: `"N"`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `SeasonType`: **(Required)** The season type.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `VsPlayerID1`: **(Required)** The first opposing player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `VsPlayerID2`: **(Required)** The second opposing player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `VsPlayerID3`: **(Required)** The third opposing player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `VsPlayerID4`: **(Required)** The fourth opposing player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`
    - `VsPlayerID5`: **(Required)** The fifth opposing player ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `VsTeamID`: **(Required)** The opposing team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Conference`: The conference.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `DateFrom`: The start date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`
    - `DateTo`: The end date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `Division`: The division.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `GameSegment`: The game segment.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"First Half"`
        - `"Overtime"`
        - `"Second Half"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"`

    - `Location`: The game location.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `Outcome`: The game outcome.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `ShotClockRange`: The shot clock range.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `VsConference`: The opposing conference.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: The opposing division.
      - _Type(s)_: `String`
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

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamAndPlayersVsPlayers.get(LastNGames: 0, MeasureType: "Base", Month: 0, OpponentTeamID: 1610612737, PaceAdjust: "N", PerMode: "PerGame", Period: 0, PlayerID1: 201939, PlayerID2: 202691, PlayerID3: 203507, PlayerID4: 1629029, PlayerID5: 1629630, PlusMinus: "N", Rank: "N", Season: "2024-25", SeasonType: "Regular Season", TeamID: 1610612744, VsPlayerID1: 1627759, VsPlayerID2: 1628369, VsPlayerID3: 1629027, VsPlayerID4: 1629631, VsPlayerID5: 1630162, VsTeamID: 1610612738)
      {:ok, %{"TeamAndPlayersVsPlayers" => [%{...}, ...]}}
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
