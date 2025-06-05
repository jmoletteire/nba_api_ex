defmodule NBA.Stats.PlayByPlayV3 do
  @moduledoc """
  Provides functions to interact with the NBA stats API for play-by-play.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playbyplayv3"

  @accepted_types %{
    EndPeriod: [:integer, nil],
    GameID: [:string],
    StartPeriod: [:integer, nil]
  }

  @default [
    EndPeriod: nil,
    GameID: nil,
    StartPeriod: nil
  ]

  @required [:GameID]

  @doc """
  Fetches play-by-play data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `EndPeriod`: The ending period for the play-by-play data.
      - _Type(s)_: `Integer | nil`
      - _Example_: `EndPeriod: 4`
      - _Default_: `nil`

    - `GameID`: **(Required)** The game ID.
      - _Type(s)_: `String`
      - _Example_: `GameID: "0022100001"`
      - _Pattern_: `^\\d{10}$`
      - _Default_: `nil`

    - `StartPeriod`: The starting period for the play-by-play data.
      - _Type(s)_: `Integer | nil`
      - _Example_: `StartPeriod: 1`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayByPlayV3.get(GameID: "0022100001", StartPeriod: 1, EndPeriod: 4)
      {:ok, %{"PlayByPlay" => [%{...}, ...]}}
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
