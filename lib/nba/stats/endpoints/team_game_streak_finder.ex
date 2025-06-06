defmodule NBA.Stats.TeamGameStreakFinder do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamGameStreakFinder.
  """

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamgamestreakfinder"

  @accepted_types %{
    TeamID: [:integer],
    Season: [:string],
    LeagueID: [:string],
    SeasonType: [:string],
    MinGames: [:integer],
    Outcome: [:string],
    VsTeamID: [:integer],
    VsDivision: [:string],
    VsConference: [:string],
    SeasonSegment: [:string],
    PORound: [:integer],
    Location: [:string],
    DateFrom: [:string],
    DateTo: [:string],
    LtAST: nil,
    LtBLK: nil,
    LtDD: nil,
    LtDREB: nil,
    LtFG3A: nil,
    LtFG3M: nil,
    LtFG3_PCT: nil,
    LtFGA: nil,
    LtFGM: nil,
    LtFG_PCT: nil,
    LtFTA: nil,
    LtFTM: nil,
    LtFT_PCT: nil,
    LtMINUTES: nil,
    LtOREB: nil,
    LtPF: nil,
    LtPTS: nil,
    LtPTS2NDCHANCE: nil,
    LtPTSFB: nil,
    LtPTSOFFTOV: nil,
    LtPTSPAINT: nil,
    LtREB: nil,
    LtSTL: nil,
    LtTD: nil,
    LtTOV: nil,
    LtOPPAST: nil,
    LtOPPBLK: nil,
    LtOPPDD: nil,
    LtOPPDREB: nil,
    LtOPPFG3A: nil,
    LtOPPFG3M: nil,
    LtOPPFG3_PCT: nil,
    LtOPPFGA: nil,
    LtOPPFGM: nil,
    LtOPPFG_PCT: nil,
    LtOPPFTA: nil,
    LtOPPFTM: nil,
    LtOPPFT_PCT: nil,
    LtOPPMINUTES: nil,
    LtOPPOREB: nil,
    LtOPPPF: nil,
    LtOPPPTS: nil,
    LtOPPTS2NDCHANCE: nil,
    LtOPPTSFB: nil,
    LtOPPTSOFFTOV: nil,
    LtOPPTSPAINT: nil,
    LtOPPREB: nil,
    LtOPPSTL: nil,
    LtOPPTD: nil,
    LtOPPTOV: nil,
    GtAST: nil,
    GtBLK: nil,
    GtDD: nil,
    GtDREB: nil,
    GtFG3A: nil,
    GtFG3M: nil,
    GtFG3_PCT: nil,
    GtFGA: nil,
    GtFGM: nil,
    GtFG_PCT: nil,
    GtFTA: nil,
    GtFTM: nil,
    GtFT_PCT: nil,
    GtMINUTES: nil,
    GtOREB: nil,
    GtPF: nil,
    GtPTS: nil,
    GtPTS2NDCHANCE: nil,
    GtPTSFB: nil,
    GtPTSOFFTOV: nil,
    GtPTSPAINT: nil,
    GtREB: nil,
    GtSTL: nil,
    GtTD: nil,
    GtTOV: nil,
    GtOPPAST: nil,
    GtOPPBLK: nil,
    GtOPPDD: nil,
    GtOPPDREB: nil,
    GtOPPFG3A: nil,
    GtOPPFG3M: nil,
    GtOPPFG3_PCT: nil,
    GtOPPFGA: nil,
    GtOPPFGM: nil,
    GtOPPFG_PCT: nil,
    GtOPPFTA: nil,
    GtOPPFTM: nil,
    GtOPPFT_PCT: nil,
    GtOPPMINUTES: nil,
    GtOPPOREB: nil,
    GtOPPPF: nil,
    GtOPPPTS: nil,
    GtOPPTS2NDCHANCE: nil,
    GtOPPTSFB: nil,
    GtOPPTSOFFTOV: nil,
    GtOPPTSPAINT: nil,
    GtOPPREB: nil,
    GtOPPSTL: nil,
    GtOPPTD: nil,
    GtOPPTOV: nil,
    EqAST: nil,
    EqBLK: nil,
    EqDD: nil,
    EqDREB: nil,
    EqFG3A: nil,
    EqFG3M: nil,
    EqFG3_PCT: nil,
    EqFGA: nil,
    EqFGM: nil,
    EqFG_PCT: nil,
    EqFTA: nil,
    EqFTM: nil,
    EqFT_PCT: nil,
    EqMINUTES: nil,
    EqOREB: nil,
    EqPF: nil,
    EqPTS: nil,
    EqPTS2NDCHANCE: nil,
    EqPTSFB: nil,
    EqPTSOFFTOV: nil,
    EqPTSPAINT: nil,
    EqREB: nil,
    EqSTL: nil,
    EqTD: nil,
    EqTOV: nil,
    EqOPPAST: nil,
    EqOPPBLK: nil,
    EqOPPDD: nil,
    EqOPPDREB: nil,
    EqOPPFG3A: nil,
    EqOPPFG3M: nil,
    EqOPPFG3_PCT: nil,
    EqOPPFGA: nil,
    EqOPPFGM: nil,
    EqOPPFG_PCT: nil,
    EqOPPFTA: nil,
    EqOPPFTM: nil,
    EqOPPFT_PCT: nil,
    EqOPPMINUTES: nil,
    EqOPPOREB: nil,
    EqOPPPF: nil,
    EqOPPPTS: nil,
    EqOPPTS2NDCHANCE: nil,
    EqOPPTSFB: nil,
    EqOPPTSOFFTOV: nil,
    EqOPPTSPAINT: nil,
    EqOPPREB: nil,
    EqOPPSTL: nil,
    EqOPPTD: nil,
    EqOPPTOV: nil,
    BtrAST: nil,
    BtrBLK: nil,
    BtrDD: nil,
    BtrDREB: nil,
    BtrFG3A: nil,
    BtrFG3M: nil,
    BtrFG3_PCT: nil,
    BtrFGA: nil,
    BtrFGM: nil,
    BtrFG_PCT: nil,
    BtrFTA: nil,
    BtrFTM: nil,
    BtrFT_PCT: nil,
    BtrMINUTES: nil,
    BtrOREB: nil,
    BtrPF: nil,
    BtrPTS: nil,
    BtrPTS2NDCHANCE: nil,
    BtrPTSFB: nil,
    BtrPTSOFFTOV: nil,
    BtrPTSPAINT: nil,
    BtrREB: nil,
    BtrSTL: nil,
    BtrTD: nil,
    BtrTOV: nil,
    BtrOPPAST: nil,
    BtrOPPBLK: nil,
    BtrOPPDD: nil,
    BtrOPPDREB: nil,
    BtrOPPFG3A: nil,
    BtrOPPFG3M: nil,
    BtrOPPFG3_PCT: nil,
    BtrOPPFGA: nil,
    BtrOPPFGM: nil,
    BtrOPPFG_PCT: nil,
    BtrOPPFTA: nil,
    BtrOPPFTM: nil,
    BtrOPPFT_PCT: nil,
    BtrOPPMINUTES: nil,
    BtrOPPOREB: nil,
    BtrOPPPF: nil,
    BtrOPPPTS: nil,
    BtrOPPTS2NDCHANCE: nil,
    BtrOPPTSFB: nil,
    BtrOPPTSOFFTOV: nil,
    BtrOPPTSPAINT: nil,
    BtrOPPREB: nil,
    BtrOPPSTL: nil,
    BtrOPPTD: nil,
    BtrOPPTOV: nil,
    WrsAST: nil,
    WrsBLK: nil,
    WrsDD: nil,
    WrsDREB: nil,
    WrsFG3A: nil,
    WrsFG3M: nil,
    WrsFG3_PCT: nil,
    WrsFGA: nil,
    WrsFGM: nil,
    WrsFG_PCT: nil,
    WrsFTA: nil,
    WrsFTM: nil,
    WrsFT_PCT: nil,
    WrsMINUTES: nil,
    WrsOREB: nil,
    WrsPF: nil,
    WrsPTS: nil,
    WrsPTS2NDCHANCE: nil,
    WrsPTSFB: nil,
    WrsPTSOFFTOV: nil,
    WrsPTSPAINT: nil,
    WrsREB: nil,
    WrsSTL: nil,
    WrsTD: nil,
    WrsTOV: nil,
    WrsOPPAST: nil,
    WrsOPPBLK: nil,
    WrsOPPDD: nil,
    WrsOPPDREB: nil,
    WrsOPPFG3A: nil,
    WrsOPPFG3M: nil,
    WrsOPPFG3_PCT: nil,
    WrsOPPFGA: nil,
    WrsOPPFGM: nil,
    WrsOPPFG_PCT: nil,
    WrsOPPFTA: nil,
    WrsOPPFTM: nil,
    WrsOPPFT_PCT: nil,
    WrsOPPMINUTES: nil,
    WrsOPPOREB: nil,
    WrsOPPPF: nil,
    WrsOPPPTS: nil,
    WrsOPPTS2NDCHANCE: nil,
    WrsOPPTSFB: nil,
    WrsOPPTSOFFTOV: nil,
    WrsOPPTSPAINT: nil,
    WrsOPPREB: nil,
    WrsOPPSTL: nil,
    WrsOPPTD: nil,
    WrsOPPTOV: nil
  }

  @default [
    TeamID: nil,
    Season: nil,
    LeagueID: "00",
    SeasonType: "Regular Season",
    MinGames: nil,
    Outcome: nil,
    VsTeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    SeasonSegment: nil,
    PORound: nil,
    Location: nil,
    DateFrom: nil,
    DateTo: nil
  ]

  @required [:Season]

  @doc """
  Fetches TeamGameStreakFinder data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - _**Note**_: This endpoint also supports a wide range of advanced stat filters in the form of `LtX`, `GtX`, and `EqX` (e.g., `LtPTS`, `GtAST`, `EqREB`), where `X` is a stat name. These accept `Integer` or `Float` values and default to `nil`.
        - `LtX`: "Less than" filter for statistic `X`.
          - _Type(s)_: `Integer` | `Float`
          - _Example_: `LtPTS: 20`
          - _Default_: `nil`
        - `GtX`: "Greater than" filter for statistic `X`.
          - _Type(s)_: `Integer` | `Float`
          - _Example_: `GtPTS: 30`
          - _Default_: `nil`
        - `EqX`: "Equal to" filter for statistic `X`.
          - _Type(s)_: `Integer` | `Float`
          - _Example_: `EqPTS: 25`
          - _Default_: `nil`

    - `ActiveStreaksOnly`: Only include active streaks.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `ActiveTeamsOnly`: Only include active teams.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Y"`
        - `"N"`

    - `Conference`: Conference filter.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `DateFrom`: Start date filter (MM/DD/YYYY).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `DateTo`: End date filter (MM/DD/YYYY).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `Division`: Division filter.
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

    - `GameID`: NBA game ID.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"`

    - `Location`: Game location.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `LStreak`: Losing streak count.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `MinGames`: Minimum number of games played.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Outcome`: Game outcome.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PORound`: Playoff round.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `Season`: The NBA season.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

    - `TeamID`: The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `VsConference`: Opponent conference.
      - _Type(s)_: `String`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

    - `VsDivision`: Opponent division.
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

    - `VsTeamID`: Opponent team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `WStreak`: Winning streak count.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamGameStreakFinder.get(TeamID: 1610612744, Season: "2024-25")
      {:ok, %{"TeamGameStreakFinder" => [%{...}, ...]}}
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
