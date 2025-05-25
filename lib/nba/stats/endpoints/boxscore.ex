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
    matchups: "boxscorematchupsv3"
  }

  @keys %{
    traditional: "Traditional",
    advanced: "Advanced",
    misc: "Misc",
    scoring: "Scoring",
    usage: "Usage",
    fourfactors: "FourFactors",
    hustle: "Hustle",
    defense: "Defensive",
    matchups: "Matchups"
  }

  @default [
    LeagueID: "00",
    endPeriod: 0,
    endRange: 31800,
    rangeType: 0,
    startPeriod: 0,
    startRange: 0
  ]

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
    - `opts`: Optional parameters for the request (e.g., custom headers, proxy settings).

  ## Example
      iex> NBA.API.BoxScore.get("traditional", "0022200001")
      {:ok, [%{"gameId" => "0022200001", ...}, ...]}

  ## Returns
    - `{:ok, box_score}`: A map containing the box score data.
    - `{:error, reason}`: An error tuple with the reason for failure.
  """
  @spec get(String.t(), keyword(), keyword()) :: {:ok, map()} | {:error, any()}
  def get(type, params \\ @default, opts \\ [])

  def get(type, params, opts) when is_binary(type) and is_list(params) and is_list(opts) do
    with :ok <- validate_params(params),
         final_params <- Keyword.merge(@default, params),
         endpoint when not is_nil(endpoint) <- Map.get(@endpoints, String.to_existing_atom(type)),
         data_key when not is_nil(data_key) <- Map.get(@keys, String.to_existing_atom(type)) do
      NBA.API.Stats.get(endpoint, final_params, opts)
      |> parse_box_score("boxScore" <> data_key)
    else
      nil ->
        {:error,
         "Invalid box score type: #{type} — valid types are #{Enum.join(Map.keys(@endpoints), ", ")}"}

      {:error, reason} ->
        {:error, reason}

      :error ->
        {:error, "Missing required parameter :GameID"}
    end
  end

  def get(type, _params, _opts) when not is_binary(type) do
    {:error, "Invalid box score type: must be a string"}
  end

  def get(_type, params, _opts) when not is_list(params) do
    {:error, "Invalid parameters: must be a keyword list"}
  end

  def get(_type, _params, opts) when not is_list(opts) do
    {:error, "Invalid options: must be a keyword list"}
  end

  def get(_type, _params, _opts) do
    {:error, "Invalid args: check your input and try again"}
  end

  defp validate_params(params) do
    if Keyword.has_key?(params, :GameID) do
      Enum.reduce_while(params, :ok, fn
        {:GameID, val}, :ok when is_binary(val) -> {:cont, :ok}
        {:LeagueID, val}, :ok when is_binary(val) -> {:cont, :ok}
        {:endPeriod, val}, :ok when is_integer(val) -> {:cont, :ok}
        {:endRange, val}, :ok when is_integer(val) -> {:cont, :ok}
        {:rangeType, val}, :ok when is_integer(val) -> {:cont, :ok}
        {:startPeriod, val}, :ok when is_integer(val) -> {:cont, :ok}
        {:startRange, val}, :ok when is_integer(val) -> {:cont, :ok}
        {key, _val}, _ -> {:halt, {:error, "Invalid type for #{inspect(key)}"}}
      end)
    else
      {:error, "Missing required parameter :GameID"}
    end
  end

  defp parse_box_score({:ok, %{data: data}}, type), do: {:ok, Map.get(data, type, {})}
  defp parse_box_score({:error, %Jason.DecodeError{}}, _type), do: {:error, :decode_error}
  defp parse_box_score({:error, _} = err, _type), do: err
  defp parse_box_score(other, _type), do: {:error, {:unexpected, other}}
end
