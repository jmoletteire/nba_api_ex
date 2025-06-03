defmodule NBA.Live.PBP do
  @moduledoc """
  Fetches play-by-play data for a specific NBA game.
  """

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playbyplay/playbyplay_"

  @accepted_types %{
    GameID: [:string]
  }
  @default [GameID: nil]
  @required [:GameID]

  @doc """
  Fetches play-by-play data for a specific game.

  ## Parameters
  - `params`: A keyword list of parameters for the request.
      - `GameID`: **(Required)** The unique identifier for the game.
        - _Type(s)_: Numeric `String`.
        - _Example_: `GameID: "0022200001"` (for a specific game).
  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
        - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Notes
  - Upcoming games will return an empty map.

  ## Returns
  - `{:ok, pbp}`: A map containing the play-by-play data for the game.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
    iex> NBA.Live.PBP.get("0042400311")
    {:ok, %{"gameId" => "0042400311", actions: [%{actionNumber: 1, ...}] ...}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         params <- Keyword.merge(@default, params),
         endpoint <- @endpoint <> params[:GameID] <> ".json" do
      case NBA.API.Live.get(endpoint, params, opts) do
        {:ok, %{data: data}} -> {:ok, data}
        {:error, %Jason.DecodeError{}} -> {:ok, %{}}
        other -> NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
