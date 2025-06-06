defmodule NBA.Stats.TeamDetails do
  @moduledoc """
  Provides functions to interact with the NBA stats API for TeamDetails.

  See `get/2` for parameter and usage details.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "teamdetails"

  @accepted_types %{
    TeamID: [:integer]
  }

  @default [
    TeamID: nil
  ]

  @required [
    :TeamID
  ]

  @doc """
  Fetches TeamDetails data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `TeamID`: **(Required)** The team ID.
      - _Type(s)_: `Integer`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.TeamDetails.get(TeamID: 1610612744)
      {:ok, %{"TeamDetails" => [%{...}, ...]}}
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
