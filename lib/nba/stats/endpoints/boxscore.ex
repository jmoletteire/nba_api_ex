defmodule NBA.Stats.BoxScore do
  @moduledoc """
  Fetches box score data for a specific game.
  """

  @endpoints %{
    traditional: "boxscoretraditionalv3",
    advanced: "boxscoreadvancedv3",
    misc: "boxscoremiscv3",
    scoring: "boxscorescoringv3",
    usage: "boxscoreusagev3",
    fourfactors: "boxscorefourfactorsv3",
    hustle: "boxscorehustlev2",
    defense: "boxscoredefensivev2",
    matchups: "boxscorematchupsv3",
    summary: "boxscoresummaryv2"
  }

  @keys %{
    traditional: "boxScoreTraditional",
    advanced: "boxScoreAdvanced",
    misc: "boxScoreMisc",
    scoring: "boxScoreScoring",
    usage: "boxScoreUsage",
    fourfactors: "boxScoreFourFactors",
    hustle: "boxScoreHustle",
    defense: "boxScoreDefensive",
    matchups: "boxScoreMatchups",
    summary: " "
  }

  @accepted_types %{
    GameID: [:string],
    LeagueID: [:string],
    endPeriod: [:integer],
    endRange: [:integer],
    rangeType: [:integer],
    startPeriod: [:integer],
    startRange: [:integer]
  }

  @default [
    LeagueID: "00",
    endPeriod: 0,
    endRange: 31800,
    rangeType: 0,
    startPeriod: 0,
    startRange: 0
  ]

  @required [:GameID]

  @doc """
  Fetches advanced box score data for a specific game.

  ## Parameters
    - `type`: The type of data to fetch (e.g., "Advanced").
      - `traditional`: Fetches traditional box score data.
      - `advanced`: Fetches advanced box score data.
      - `misc`: Fetches miscellaneous box score data.
      - `scoring`: Fetches scoring box score data.
      - `usage`: Fetches usage box score data.
      - `fourfactors`: Fetches four factors box score data.
      - `hustle`: Fetches hustle box score data.
      - `defense`: Fetches defensive box score data.
      - `matchups`: Fetches matchups box score data.
    - `params`: A keyword list of parameters for the request.
      - `GameID`: **(Required)** The unique identifier for the game.
        - _Type(s)_: Numeric `String`.
        - _Example_: `GameID: "0022200001"` (for a specific game).
      - `LeagueID`: The league ID.
        - _Type(s)_: Numeric `String`.
        - _Default_: `"00"` (NBA).
        - _Example_: `LeagueID: "10"` (for WNBA).
        - _Valueset_:
          - `"00"` (NBA)
          - `"01"` (ABA)
          - `"10"` (WNBA)
          - `"20"` (G-League)
      - `endPeriod`: The end period for the box score data.
        - _Type(s)_: `Integer`.
        - _Default_: `0` (all periods).
        - _Example_: `endPeriod: 4`.
      - `endRange`: The end range for the box score data in seconds.
        - _Type(s)_: `Integer`.
        - _Default_: `31800` (full game).
        - _Example_: `endRange: 3600` (for the first hour).
      - `rangeType`: The type of range for the box score data.
        - _Type(s)_: `Integer`.
        - _Default_: `0` (full game).
        - _Example_: `rangeType: 1` (for first half).
      - `startPeriod`: The start period for the box score data.
        - _Type(s)_: `Integer`.
        - _Default_: `0` (all periods).
        - _Example_: `startPeriod: 1`.
      - `startRange`: The start range for the box score data in seconds.
        - _Type(s)_: `Integer`.
        - _Default_: `0` (start of game).
        - _Example_: `startRange: 1800` (for the first 30 minutes).
      - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
        - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.API.BoxScore.get(:traditional, GameID: "0022200001")
      {:ok, [%{"gameId" => "0022200001", ...}, ...]}

  ## Returns
    - `{:ok, box_score}`: A map containing the box score data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(atom(), keyword(), keyword()) :: {:ok, map()} | {:error, String.t()}
  def get(type, params \\ @default, opts \\ [])

  def get(type, params, opts) when is_atom(type) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         endpoint when not is_nil(endpoint) <- Map.get(@endpoints, type),
         data_key when not is_nil(data_key) <- Map.get(@keys, type),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(endpoint, params, opts) do
        {:ok, %{data: data}} when type == :summary -> {:ok, data}
        {:ok, %{data: data}} -> {:ok, Map.get(data, data_key, %{})}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      nil ->
        {:error, "Box score type #{inspect(type)} is not supported."}

      err ->
        NBA.Utils.handle_validation_error(err)
    end
  end

  def get(type, _params, _opts) do
    {:error, "Received Box Score type #{inspect(type)}, expected atom :#{type}"}
  end

  def get!(type, params \\ @default, opts \\ []) do
    case get(type, params, opts) do
      {:ok, data} -> data
      {:error, reason} -> raise "Failed to fetch box score: #{reason}"
    end
  end
end
