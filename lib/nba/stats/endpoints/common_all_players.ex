defmodule NBA.Stats.CommonAllPlayers do
  @moduledoc """
  Fetches all players data from the NBA API.
  """

  @endpoint "commonallplayers"

  @accepted_types %{
    LeagueID: [:string],
    IsOnlyCurrentSeason: [:string],
    Season: [:string]
  }

  @default [LeagueID: "00", IsOnlyCurrentSeason: "0", Season: "2024-25"]

  @doc """

  Fetches all players with optional parameters.

  ## Parameters
    - `params`: A keyword list of parameters for the request.
      - `LeagueID`: The league ID.
        - _Type(s)_: `String`
        - _Default_: `"00"` (NBA)
        - _Example_: `LeagueID: "10"`
        - _Valueset_:
          - `"00"` (NBA)
          - `"01"` (ABA)
          - `"10"` (WNBA)
          - `"20"` (G-League)
      - `IsOnlyCurrentSeason`: Whether to fetch only current season players.
        - _Type(s)_: `String`
        - _Default_: `"0"` (All Seasons)
        - _Example_: `IsOnlyCurrentSeason: "1"`
        - _Valueset_:
          - `"0"` (All Seasons)
          - `"1"` (Only Current Season)
      - `Season`: The season to fetch players for.
        - _Type(s)_: `String`
        - _Default_: `"2024-25"`
        - _Example_: `Season: "2021-22"`
    - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Example
      iex> NBA.Stats.CommonAllPlayers.get()
      {:ok, [%{"DISPLAY_FIRST_LAST" => "LeBron James", ...}, ...]}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types) do
      params = Keyword.merge(@default, params)

      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, Map.get(data, "CommonAllPlayers", [])}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end

  @doc """
  Same as `get/2`, but raises an exception on error and returns only the response on success.

  ## Example

      iex> NBA.Stats.CommonAllPlayers.get!()
      [%{"DISPLAY_FIRST_LAST" => "LeBron James", ...}, ...]

      iex> NBA.Stats.CommonAllPlayers.get!(LeagueID: "invalid")
      ** (ArgumentError) Invalid parameters: ...
  """
  def get!(params \\ @default, opts \\ []) do
    case get(params, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise ArgumentError, "Failed to fetch CommonAllPlayers: #{inspect(reason)}"
    end
  end
end
