defmodule NBA.Stats.CommonAllPlayers do
  @moduledoc """
  Fetches all players data from the NBA API.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

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

  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.CommonAllPlayers.get()
      {:ok, [%{"DISPLAY_FIRST_LAST" => "LeBron James", ...}, ...]}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types),
         params <- Keyword.merge(@default, params) do
      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, Map.get(data, "CommonAllPlayers", [])}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
