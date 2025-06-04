defmodule NBA.Stats.DraftCombine do
  @endpoints %{
    anthro: "draftcombineplayeranthro",
    drills: "draftcombinedrillresults",
    spot: "draftcombinespotshooting",
    stats: "draftcombinestats",
    nonstationary: "draftcombinenonstationaryshooting"
  }

  @accepted_types %{
    LeagueID: [:string],
    SeasonYear: [:string]
  }

  @default [LeagueID: "00"]

  @required [:SeasonYear]

  @doc """
  Fetches specified type of draft combine data for a given year.

  ## Parameters
    - `type`: The type of data to fetch (e.g., "Advanced").
      - `anthro`: Fetches player anthropometric data.
      - `drills`: Fetches player drill results.
      - `spot`: Fetches player spot shooting data.
      - `stats`: Fetches player stats.
      - `nonstationary`: Fetches player movement shooting data.
    - `params`: A keyword list of parameters for the request.
      - `LeagueID`: The league ID.
        - _Type(s)_: Numeric `String`.
        - _Default_: `"00"` (NBA).
        - _Example_: `LeagueID: "10"` (for WNBA).
        - _Valueset_:
          - `"00"` (NBA)
          - `"01"` (ABA)
          - `"10"` (WNBA)
          - `"20"` (G-League)
      - `SeasonYear`: **(Required)** The season year for the draft combine data.
        - _Type(s)_: Numeric `String`.
        - _Example_: `SeasonYear: "2023"` (for the 2023 draft combine).
      - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
        - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
    - `{:ok, response}`: A map containing the box score data.
    - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
    iex> NBA.Stats.DraftCombine.get(:anthro, SeasonYear: "2023")
    {:ok, %{data: [%{"PLAYER_ID" => 12345, "Height" => "6-7", "Weight" => 210}]}}
  """
  @spec get(atom(), keyword(), keyword()) :: {:ok, map()} | {:error, String.t()}
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
      {:error, reason} -> raise "Failed to fetch draft combine data: #{reason}"
    end
  end
end
