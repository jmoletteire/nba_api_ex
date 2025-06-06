defmodule NBA.Stats.WinProbabilityPBP do
  @moduledoc """
  Provides functions to interact with the NBA stats API for WinProbabilityPBP.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "winprobabilitypbp"

  @accepted_types %{
    GameID: [:string],
    RunType: [:string]
  }

  @default [
    GameID: nil,
    RunType: "each second"
  ]

  @required [
    :GameID,
    :RunType
  ]

  @doc """
  Fetches WinProbabilityPBP data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `GameID`: **(Required)** The game ID.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `RunType`: The run type.
      - _Type(s)_: `String`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.WinProbabilityPBP.get(GameID: "0022100001", RunType: "single")
      {:ok, %{"WinProbabilityPBP" => [%{...}, ...]}}
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
