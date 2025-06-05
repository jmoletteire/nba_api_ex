defmodule NBA.Stats.PlayerVsPlayer do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerVsPlayer.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playervsplayer"

  @accepted_types %{
    LastNGames: [:integer],
    MeasureType: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    PaceAdjust: [:string],
    PerMode: [:string],
    Period: [:integer],
    PlayerID: [:integer, :string],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonType: [:string],
    VsPlayerID: [:integer, :string],
    VsDivision: [:string],
    VsConference: [:string],
    SeasonSegment: [:string],
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
    PaceAdjust: "Y",
    PerMode: "PerGame",
    Period: 0,
    PlayerID: nil,
    PlusMinus: "Y",
    Rank: "Y",
    Season: nil,
    SeasonType: "Regular Season",
    VsPlayerID: nil,
    VsDivision: nil,
    VsConference: nil,
    SeasonSegment: nil,
    Outcome: nil,
    Location: nil,
    LeagueID: "00",
    GameSegment: nil,
    DateTo: nil,
    DateFrom: nil
  ]

  @required [
    :PlayerID,
    :Season,
    :VsPlayerID
  ]

  @doc """
  Fetches PlayerVsPlayer data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LastNGames`: **(Required)** Number of last games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 5`
      - _Default_: `0`

    - `MeasureType`: **(Required)** The type of measure. Accepts one of `"Base"`, `"Advanced"`, `"Misc"`, `"Four Factors"`, `"Scoring"`, `"Opponent"`, `"Usage"`, `"Defense"`.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `"Base"`
      - _Valueset_: `"Base"`, `"Advanced"`, `"Misc"`, `"Four Factors"`, `"Scoring"`, `"Opponent"`, `"Usage"`, `"Defense"`
      - _Pattern_: `^(Base)|(Advanced)|(Misc)|(Four Factors)|(Scoring)|(Opponent)|(Usage)|(Defense)$`

    - `Month`: **(Required)** The month (1-12, 0 for all).
      - _Type(s)_: `Integer`
      - _Example_: `Month: 0`
      - _Default_: `0`

    - `OpponentTeamID`: **(Required)** The opponent team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `OpponentTeamID: 1610612737`
      - _Default_: `0`

    - `PaceAdjust`: **(Required)** Whether to adjust for pace. Accepts `"Y"` or `"N"`.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "N"`
      - _Default_: `"N"`
      - _Valueset_: `"Y"`, `"N"`
      - _Pattern_: `^(Y)|(N)$`

    - `PerMode`: **(Required)** The data aggregation mode. Accepts one of `"Totals"`, `"PerGame"`, `"MinutesPer"`, `"Per48"`, `"Per40"`, `"Per36"`, `"PerMinute"`, `"PerPossession"`, `"PerPlay"`, `"Per100Possessions"`, `"Per100Plays"`.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "PerGame"`
      - _Default_: `"PerGame"`
      - _Valueset_: `"Totals"`, `"PerGame"`, `"MinutesPer"`, `"Per48"`, `"Per40"`, `"Per36"`, `"PerMinute"`, `"PerPossession"`, `"PerPlay"`, `"Per100Possessions"`, `"Per100Plays"`
      - _Pattern_: `^(Totals)|(PerGame)|(MinutesPer)|(Per48)|(Per40)|(Per36)|(PerMinute)|(PerPossession)|(PerPlay)|(Per100Possessions)|(Per100Plays)$`

    - `Period`: **(Required)** The period (0 for all).
      - _Type(s)_: `Integer`
      - _Example_: `Period: 0`
      - _Default_: `0`

    - `PlayerID`: **(Required)** The player ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PlayerID: 201939`
      - _Default_: `nil`

    - `PlusMinus`: **(Required)** Whether to include plus/minus. Accepts `"Y"` or `"N"`.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "N"`
      - _Default_: `"N"`
      - _Valueset_: `"Y"`, `"N"`
      - _Pattern_: `^(Y)|(N)$`

    - `Rank`: **(Required)** Whether to include rank. Accepts `"Y"` or `"N"`.
      - _Type(s)_: `String`
      - _Example_: `Rank: "N"`
      - _Default_: `"N"`
      - _Valueset_: `"Y"`, `"N"`
      - _Pattern_: `^(Y)|(N)$`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `SeasonType`: **(Required)** The season type. Accepts one of `"Regular Season"`, `"Pre Season"`, `"Playoffs"`.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_: `"Regular Season"`, `"Pre Season"`, `"Playoffs"`
      - _Pattern_: `^(Regular Season)|(Pre Season)|(Playoffs)$`

    - `VsPlayerID`: **(Required)** The opposing player ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `VsPlayerID: 2544`
      - _Default_: `nil`

    - `VsDivision`: The opposing division. Accepts `nil` or one of `"Atlantic"`, `"Central"`, `"Northwest"`, `"Pacific"`, `"Southeast"`, `"Southwest"`, `"East"`, `"West"`.
      - _Type(s)_: `String` | `nil`
      - _Example_: `VsDivision: "Pacific"`
      - _Default_: `nil`
      - _Pattern_: `^((Atlantic)|(Central)|(Northwest)|(Pacific)|(Southeast)|(Southwest)|(East)|(West))?$`

    - `VsConference`: The opposing conference. Accepts `nil` or `"East"`, `"West"`.
      - _Type(s)_: `String` | `nil`
      - _Example_: `VsConference: "West"`
      - _Default_: `nil`
      - _Pattern_: `^((East)|(West))?$`

    - `SeasonSegment`: The season segment. Accepts `nil` or `"Post All-Star"`, `"Pre All-Star"`.
      - _Type(s)_: `String` | `nil`
      - _Example_: `SeasonSegment: "Pre All-Star"`
      - _Default_: `nil`
      - _Pattern_: `^((Post All-Star)|(Pre All-Star))?$`

    - `Outcome`: The game outcome. Accepts `nil` or `"W"`, `"L"`.
      - _Type(s)_: `String` | `nil`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Pattern_: `^((W)|(L))?$`

    - `Location`: The game location. Accepts `nil` or `"Home"`, `"Road"`.
      - _Type(s)_: `String` | `nil`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Pattern_: `^((Home)|(Road))?$`

    - `LeagueID`: The league ID. Defaults to `"00"` (NBA). Not required.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`

    - `GameSegment`: The game segment. Accepts `nil` or `"First Half"`, `"Overtime"`, `"Second Half"`.
      - _Type(s)_: `String` | `nil`
      - _Example_: `GameSegment: "First Half"`
      - _Default_: `nil`
      - _Pattern_: `^((First Half)|(Overtime)|(Second Half))?$`

    - `DateTo`: The end date (YYYY-MM-DD). Accepts `nil` or a date string.
      - _Type(s)_: `String` | `nil`
      - _Example_: `DateTo: "2025-03-01"`
      - _Default_: `nil`

    - `DateFrom`: The start date (YYYY-MM-DD). Accepts `nil` or a date string.
      - _Type(s)_: `String` | `nil`
      - _Example_: `DateFrom: "2025-01-01"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerVsPlayer.get(Season: "2024-25", PlayerID: 201939, VsPlayerID: 2544)
      {:ok, %{"PlayerVsPlayer" => [%{...}, ...]}}
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
