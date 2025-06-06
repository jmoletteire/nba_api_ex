defmodule NBA.Stats.PlayoffPicture do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayoffPicture.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playoffpicture"

  @accepted_types %{
    LeagueID: [:string],
    SeasonID: [:string]
  }

  @default [
    LeagueID: "00",
    SeasonID: nil
  ]

  @required [:SeasonID]

  @doc """
  Fetches PlayoffPicture data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LeagueID`: **(Required)** The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Pattern_: `^\\d{2}$`

    - `SeasonID`: The season ID.
      - _Type(s)_: `String`
      - _Example_: `SeasonID: "22022"`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayoffPicture.get(LeagueID: "00", SeasonID: "22022")
      {:ok, %{"PlayoffPicture" => [%{...}, ...]}}
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
