defmodule NBA.Stats.GameRotation do
  @moduledoc """
  Handles requests to the NBA stats game rotation endpoint.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "gamerotation"

  @accepted_types %{GameID: [:string], LeagueID: [:string]}
  @default [LeagueID: "00"]
  @required [:GameID]

  @doc """
  Fetches game rotation data for a specific game.
  ## Parameters
  - `params`: A keyword list of parameters, including:
    - `GameID`: **(Required)** The game ID.
      - _Type(s)_: `String`
      - _Example_: `GameID: "0022200001"`
    - `LeagueID`: The league ID (optional).
      - _Type(s)_: `String`
      - _Default_: `"00"` (NBA)
      - _Example_: `LeagueID: "10"` (for WNBA)
      - _Valueset_:
        - `"00"` (NBA)
        - `"01"` (ABA)
        - `"10"` (WNBA)
        - `"20"` (G-League)
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.

  ## Returns
  - `{:ok, data}`: On success, returns a map containing the game rotation data.
  - `{:error, reason}`: On failure, returns an error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.GameRotation.get(GameID: "0022200001")
      {:ok, %{status: 200, data: %{"GameRotation" => [...]}}}
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
