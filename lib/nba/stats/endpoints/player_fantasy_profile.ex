defmodule NBA.Stats.PlayerFantasyProfile do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerFantasyProfile.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playerfantasyprofile"

  @accepted_types %{
    MeasureType: [:string],
    PaceAdjust: [:string],
    PerMode: [:string],
    PlayerID: [:integer, :string],
    PlusMinus: [:string],
    Rank: [:string],
    Season: [:string],
    SeasonType: [:string],
    LeagueID: [:string]
  }

  @default [
    MeasureType: "Base",
    PaceAdjust: "Y",
    PerMode: "Totals",
    PlayerID: nil,
    PlusMinus: "Y",
    Rank: "Y",
    Season: nil,
    SeasonType: "Regular Season",
    LeagueID: "00"
  ]

  @required [:PlayerID, :Season]

  @doc """
  Fetches PlayerFantasyProfile data.

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

    - `MeasureType`: The type of measure.
      - _Type(s)_: `String`
      - _Example_: `MeasureType: "Base"`
      - _Default_: `"Base"`
      - _Valueset_:
        - `"Base"`

    - `PaceAdjust`: Whether to adjust for pace.
      - _Type(s)_: `String`
      - _Example_: `PaceAdjust: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"N"`

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `"Totals"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`
        - `"Per36"`

    - `PlusMinus`: Whether to include plus/minus.
      - _Type(s)_: `String`
      - _Example_: `PlusMinus: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"N"`

    - `Rank`: Whether to include rank.
      - _Type(s)_: `String`
      - _Example_: `Rank: "N"`
      - _Default_: `"N"`
      - _Valueset_:
        - `"N"`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `nil`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerFantasyProfile.get(PlayerID: 201939, Season: "2024-25")
      {:ok, %{"PlayerFantasyProfile" => [%{...}, ...]}}
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
