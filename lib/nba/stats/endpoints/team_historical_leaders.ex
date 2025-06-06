defmodule NBA.Stats.TeamHistoricalLeaders do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamHistoricalLeaders.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamhistoricalleaders"

  @accepted_types %{
    LeagueID: [:string],
    SeasonID: [:string],
    TeamID: [:integer]
  }

  @default [
    LeagueID: "00",
    SeasonID: nil,
    TeamID: nil
  ]

  @required [
    :SeasonID,
    :TeamID
  ]

  @doc """
  Fetches TeamHistoricalLeaders data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `SeasonID`: **(Required)** The season ID (5-digit string, e.g. "22015").
      - _Type(s)_: `String`
      - _Default_: `nil`

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
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
      iex> NBA.Stats.TeamHistoricalLeaders.get(SeasonID: "22015", TeamID: 1610612744)
      {:ok, %{"TeamHistoricalLeaders" => [%{...}, ...]}}
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
