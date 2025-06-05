defmodule NBA.Stats.PlayerIndex do
  @moduledoc """
  Provides functions to interact with the NBA stats API for PlayerIndex.

  See `get/2` for parameter and usage details.
  """
  require NBA.Utils
  NBA.Utils.def_get_bang(__MODULE__)

  @endpoint "playerindex"

  @accepted_types %{
    Active: [:integer],
    AllStar: [:integer],
    College: [:string],
    Country: [:string],
    DraftPick: [:string],
    DraftRound: [:string],
    DraftYear: [:string],
    Height: [:string],
    Historical: [:integer],
    LeagueID: [:string],
    Season: [:string],
    TeamID: [:integer, :string],
    Weight: [:integer]
  }

  @default [
    Active: nil,
    AllStar: nil,
    College: nil,
    Country: nil,
    DraftPick: nil,
    DraftRound: nil,
    DraftYear: nil,
    Height: nil,
    Historical: 1,
    LeagueID: "00",
    Season: nil,
    TeamID: 0,
    Weight: nil
  ]

  @required [:Season]

  @doc """
  Fetches PlayerIndex data.

  ## Parameters
  - `params`: A keyword list of parameters to filter the data.

    - `LeagueID`: **(Required)** The league ID.
      - _Type(s)_: `String`
      - _Example_: `LeagueID: "00"`
      - _Default_: `"00"`
      - _Pattern_: `^\\d{2}$`

    - `Season`: **(Required)** The season.
      - _Type(s)_: `String`
      - _Example_: `Season: "2024-25"`
      - _Default_: `nil`
      - _Pattern_: `^(\\d{4}-\\d{2})$`

    - `Active`: Whether the player is active.
      - _Type(s)_: `Integer`
      - _Example_: `Active: 1`
      - _Default_: `nil`

    - `AllStar`: Whether the player is an all-star.
      - _Type(s)_: `Integer`
      - _Example_: `AllStar: 1`
      - _Default_: `nil`

    - `College`: The college attended.
      - _Type(s)_: `String`
      - _Example_: `College: "Duke"`
      - _Default_: `nil`

    - `Country`: The country of origin.
      - _Type(s)_: `String`
      - _Example_: `Country: "USA"`
      - _Default_: `nil`

    - `DraftPick`: The draft pick.
      - _Type(s)_: `String`
      - _Example_: `DraftPick: "1"`
      - _Default_: `nil`

    - `DraftRound`: The draft round.
      - _Type(s)_: `String`
      - _Example_: `DraftRound: "1"`
      - _Default_: `nil`

    - `DraftYear`: The draft year.
      - _Type(s)_: `String`
      - _Example_: `DraftYear: "2003"`
      - _Default_: `nil`

    - `Height`: The height.
      - _Type(s)_: `String`
      - _Example_: `Height: "6-8"`
      - _Default_: `nil`

    - `Historical`: Whether the player is historical.
      - _Type(s)_: `Integer`
      - _Example_: `Historical: 1`
      - _Default_: `nil`

    - `TeamID`: The team ID.
      - _Type(s)_: `Integer` | `String`
      - _Example_: `TeamID: 1610612737`
      - _Default_: `nil`

    - `Weight`: The weight.
      - _Type(s)_: `Integer`
      - _Example_: `Weight: 250`
      - _Default_: `nil`

  - `opts`: A keyword list of additional options for the request, such as headers or timeout settings.
      - For a full list of options, see the [Req documentation](https://hexdocs.pm/req/Req.html#new/1).

  ## Returns
  - `{:ok, data}`: On success, returns the data from the API.
  - `{:error, reason}`: On failure, returns an error tuple with the reason.

  ## Example
      iex> NBA.Stats.PlayerIndex.get(LeagueID: "00", Season: "2024-25")
      {:ok, %{"PlayerIndex" => [%{...}, ...]}}
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
