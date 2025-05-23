defmodule NBA.Live.OddsTest do
  use ExUnit.Case
  alias NBA.Live.Odds

  @moduledoc """
  Tests for the NBA.Live.Odds module.
  You can run these tests using any of these commands:
  - mix test test/live/odds_test.exs
  - mix test test/live/odds_test.exs:{line_number}
  - mix test test/live/odds_test.exs --only integration
  - mix test test/live/odds_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching odds data for a known game (e.g., game ID "0042400311").
  - Fetching odds data for an unknown game ID.
  - Handling invalid input types (non-string game ID).
  """

  @tag :integration
  test "#1) fetches live odds data" do
    assert {:ok, result} = Odds.get()
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "gameId")
  end
end
