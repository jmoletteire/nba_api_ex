defmodule NBA.Stats.ScheduleLeagueV2 do
  @moduledoc """
  Provides functions to interact with the NBA stats API for ScheduleLeagueV2.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "scheduleleaguev2"

  @accepted_types %{
    LeagueID: [:string],
    Season: [:string]
  }

  @default [
    LeagueID: "00",
    Season: nil
  ]

  @required [:Season]

  @doc """
  Fetches ScheduleLeagueV2 data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LeagueID`: The league ID. Defaults to `"00"` (NBA). Not required.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.ScheduleLeagueV2.get(Season: "2024-25")
      {:ok, %{"ScheduleLeagueV2" => [%{...}, ...]}}
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
