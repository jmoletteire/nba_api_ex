defmodule NBA.Stats.PlayerAwards do
  @moduledoc """
  Fetches award data for a specific NBA player.
  """

  @moduledoc since: "0.1.0"

  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playerawards"

  @keys ~w(DESCRIPTION ALL_NBA_TEAM_NUMBER SEASON CONFERENCE TYPE)

  @accepted_types %{
    PlayerID: [:integer, :string]
  }

  @default [PlayerID: nil]

  @required [:PlayerID]

  @doc """
  Fetches awards for a specific player.

  ## Parameters
  - `params`: A keyword list of parameters for the request.
    - `PlayerID`: **(Required)** The ID of the player to fetch awards for.
      - _Type(s)_: `Integer`, Numeric `String`.
      - _Example_: `PlayerID: 2544` (for LeBron James).
  - `opts`: A keyword list of options for the request, such as headers or timeout settings.
    - For a list of available options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, awards}`: A map of awards grouped by award name.
  - `{:error, reason}`: An error tuple with the reason for failure.

  ## Example
      iex> NBA.Stats.PlayerAwards.get(PlayerID: "2544")
      {:ok, %{"All-NBA" => [%{"DESCRIPTION" => "All-NBA", ...}]}}
  """
  def get(params \\ @default, opts \\ []) do
    with :ok <- NBA.Utils.validate_input(params, opts, @accepted_types, @required),
         player_id <- NBA.Utils.integer_id(Keyword.get(params, :PlayerID)) do
      params =
        Keyword.merge(@default, params)
        |> Keyword.put_new(:PlayerID, player_id)

      case NBA.API.Stats.get(@endpoint, params, opts) do
        {:ok, %{data: %{"PlayerAwards" => awards}}} ->
          Enum.group_by(awards, &Map.get(&1, "DESCRIPTION", "UNKNOWN"), fn award ->
            Map.take(award, @keys)
          end)
          |> then(&{:ok, &1})

        other ->
          NBA.Utils.handle_api_error(other)
      end
    else
      err -> NBA.Utils.handle_validation_error(err)
    end
  end
end
