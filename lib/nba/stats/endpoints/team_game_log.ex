defmodule NBA.Stats.TeamGameLog do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamGameLog.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamgamelog"

  @accepted_types %{
    Season: [:string],
    SeasonType: [:string],
    TeamID: [:integer],
    LeagueID: [:string],
    DateTo: [:string],
    DateFrom: [:string]
  }

  @default [
    Season: nil,
    SeasonType: "Regular Season",
    TeamID: nil,
    LeagueID: "00",
    DateTo: nil,
    DateFrom: nil
  ]

  @required [
    :Season,
    :TeamID
  ]

  @doc """
  Fetches TeamGameLog data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

    - `SeasonType`: The season type.
      - _Type(s)_: `String`
      - _Default_: `"Regular Season"`
      - _Valueset_:
        - `"Regular Season"`
        - `"Pre Season"`
        - `"Playoffs"`
        - `"All-Star"`
        - `"All Star"`
        - `"Preseason"`

    - `LeagueID`: The league ID.
      - _Type(s)_: `String`
      - _Default_: `"00"`

    - `DateTo`: The end date (MM/DD/YYYY).
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `DateFrom`: The start date (MM/DD/YYYY).
      - _Type(s)_: `String`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamGameLog.get(Season: "2024-25", TeamID: 1610612744)
      {:ok, %{"TeamGameLog" => [%{...}, ...]}}
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
