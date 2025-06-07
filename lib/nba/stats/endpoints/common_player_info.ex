defmodule NBA.Stats.CommonPlayerInfo do
  @moduledoc """
  Provides functions to fetch common player information from the NBA Stats API.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "commonplayerinfo"

  @accepted_types %{
    PlayerID: [:integer, :string],
    LeagueID: [:string]
  }

  @default [LeagueID: "00"]

  @required [:PlayerID]

  @doc """

  Fetches common player information from the NBA Stats API.
  This function retrieves player details based on the provided parameters.

  ## Parameters
  - `params`: A keyword list of parameters to filter the player information.

    - `PlayerID`: **(Required)** The unique identifier for the player.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `PlayerID: 2544` or `PlayerID: "2544"` (for LeBron James).

    - `LeagueID`: The league ID.
      - _Type(s)_: Numeric `String`
      - _Default_: `"00"` (NBA).
      - _Example_: `LeagueID: "10"` (for WNBA).
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.CommonPlayerInfo.get(PlayerID: 2544)
      {:ok, %{"name" => "LeBron James", ...}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         player_id <- NBA.Utils.integer_id(Keyword.get(params, :PlayerID)) do
      params =
        Keyword.merge(@default, params)
        |> Keyword.put_new(:PlayerID, player_id)

      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, Map.get(data, "CommonPlayerInfo", [])}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
