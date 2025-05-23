defmodule NBA.Stats.LeagueLeadersTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueLeaders

  @moduledoc """
  Tests for the NBA.Stats.LeagueLeaders module.
  You can run these tests using any of these commands:
  - mix test test/stats/league_leaders_test.exs
  - mix test test/stats/league_leaders_test.exs:{line_number}
  - mix test test/stats/league_leaders_test.exs --only integration
  - mix test test/stats/league_leaders_test.exs --only unit
  The tests cover the following scenarios:
  - Fetching all-time leaders data.
  - Handling invalid input types (non-keyword list).
  """
  @tag :integration
  test "fetches all-time leaders data" do
    assert {:ok, result} = LeagueLeaders.get()
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "PLAYER_ID")
    IO.inspect(hd(result))
  end

  # @tag :unit
  # test "handles invalid input types" do
  #   assert {:error, "Invalid options: must be a keyword list"} =
  #            LeagueLeaders.get("invalid")

  #   assert {:error, "Invalid options: must be a keyword list"} = LeagueLeaders.get(123)
  # end
end
