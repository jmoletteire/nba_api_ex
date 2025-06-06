defmodule NBA.Stats.VideoStatus do
  @moduledoc """
  Provides functions to interact with the NBA stats API for VideoStatus.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "videostatus"

  @accepted_types %{
    GameDate: [:string],
    LeagueID: [:string]
  }

  @default [
    GameDate: nil,
    LeagueID: "00"
  ]

  @required [:GameDate]

  @doc """
  Fetches VideoStatus data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `GameDate`: **(Required)** The game date (YYYY-MM-DD).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `LeagueID`: The league ID (2-digit string).
      - _Type(s)_: `String`
      - _Default_: `"00"`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.VideoStatus.get(GameDate: "2025-06-06", LeagueID: "00")
      {:ok, %{"VideoStatus" => [%{...}, ...]}}
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
