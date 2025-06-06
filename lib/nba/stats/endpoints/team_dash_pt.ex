defmodule NBA.Stats.TeamDashPt do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamDashPt.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  @endpoints %{
    passing: "teamdashptpass",
    rebounding: "teamdashptreb",
    shooting: "teamdashptshots"
  }

  @accepted_types %{
    LastNGames: [:integer],
    LeagueID: [:string],
    Month: [:integer],
    OpponentTeamID: [:integer, :string],
    PerMode: [:string],
    Period: [:integer],
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer, :string],
    VsDivision: [:string],
    VsConference: [:string],
    SeasonSegment: [:string],
    Outcome: [:string],
    Location: [:string],
    GameSegment: [:string],
    DateTo: [:string],
    DateFrom: [:string]
  }

  @default [
    LastNGames: 0,
    LeagueID: "00",
    Month: 0,
    OpponentTeamID: 0,
    PerMode: "Totals",
    Period: 0,
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    VsDivision: nil,
    VsConference: nil,
    SeasonSegment: nil,
    Outcome: nil,
    Location: nil,
    GameSegment: nil,
    DateTo: nil,
    DateFrom: nil
  ]

  @required [:TeamID, :Season]

  @doc """
  Fetches TeamDashPtPass data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.
    - `type`: The type of player tracking data to fetch.
      - _Type(s)_: `atom()`
      - _Example_: `:passing`
      - _Default_: `nil`
      - _Valueset_:
        - `:passing` (Passing stats)
        - `:rebounding` (Rebounding stats)
        - `:shooting` (Shooting stats)

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer | String`
      - _Example_: `TeamID: 1610612737`
      - _Default_: `nil`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

    - `DateTo`: The end date.
      - _Type(s)_: `String`
      - _Example_: `DateTo: "2024-01-31"`
      - _Default_: `nil`

    - `DateFrom`: The start date.
      - _Type(s)_: `String`
      - _Example_: `DateFrom: "2024-01-01"`
      - _Default_: `nil`

    - `LastNGames`: Number of last games to include.
      - _Type(s)_: `Integer`
      - _Example_: `LastNGames: 10`
      - _Default_: `0`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G League)

    - `Location`: The location.
      - _Type(s)_: `String`
      - _Example_: `Location: "Home"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Home"`
        - `"Road"`

    - `Month`: The month number.
      - _Type(s)_: `Integer`
      - _Example_: `Month: 1`
      - _Default_: `0`

    - `OpponentTeamID`: The opponent team ID.
      - _Type(s)_: `Integer | String`
      - _Example_: `OpponentTeamID: 1610612737`
      - _Default_: `0`

    - `Outcome`: The outcome.
      - _Type(s)_: `String`
      - _Example_: `Outcome: "W"`
      - _Default_: `nil`
      - _Valueset_:
        - `"W"`
        - `"L"`

    - `PerMode`: How to aggregate stats.
      - _Type(s)_: `String`
      - _Example_: `PerMode: "Totals"`
      - _Default_: `"Totals"`
      - _Valueset_:
        - `"Totals"`
        - `"PerGame"`

    - `SeasonSegment`: The season segment.
      - _Type(s)_: `String`
      - _Example_: `SeasonSegment: "Pre All-Star"`
      - _Default_: `nil`
      - _Valueset_:
        - `"Post All-Star"`
        - `"Pre All-Star"`

    - `SeasonType`: The type of season.
      - _Type(s)_: `String`
      - _Example_: `SeasonType: "Regular Season"`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All Star"`

    - `VsDivision`: The vs division.
      - _Type(s)_: `String`
      - _Example_: `VsDivision: "Atlantic"`
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

    - `VsConference`: The vs conference.
      - _Type(s)_: `String`
      - _Example_: `VsConference: "East"`
      - _Default_: `nil`
      - _Valueset_:
        - `"East"`
        - `"West"`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamDashPt.get(:passing, TeamID: 1610612737, Season: "2024-25")
      {:ok, %{"TeamDashPtPass" => [%{...}, ...]}}
  """
  @spec get(atom(), Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, any()}
  def get(type, params \\ @default, opts \\ [])

  def get(type, params, opts) when is_atom(type) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         endpoint when not is_nil(endpoint) <- Map.get(@endpoints, type),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      nil ->
        {:error, "Endpoint #{inspect(type)} is not supported."}

      err ->
        NBA.Utils.handle_validation_error(err)
    end
  end

  def get(type, _params, _opts) do
    {:error, "Received endpoint type #{inspect(type)}, expected atom :#{type}"}
  end

  def get!(type, params \\ @default, opts \\ []) do
    case get(type, params, opts) do
      {:ok, data} -> data
      {:error, reason} -> raise "Failed to fetch team player tracking dashboard data: #{reason}"
    end
  end
end
