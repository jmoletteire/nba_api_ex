defmodule NBA.Live.BoxScoreTest do
  use ExUnit.Case
  alias NBA.Live.BoxScore

  @moduledoc """
  Tests for the NBA.Live.BoxScore module.
  You can run these tests using any of these commands:
  - mix test test/live/boxscore_test.exs
  - mix test test/live/boxscore_test.exs:{line_number}
  - mix test test/live/boxscore_test.exs --only integration
  - mix test test/live/boxscore_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching boxscore data for a known game (e.g., game ID "0042400311").
  - Fetching boxscore data for an unknown game ID.
  - Handling invalid input types (non-string game ID).
  """

  @tag :integration
  test "fetches boxscore data for a known game" do
    # Known game ID
    game_id = "0042400311"
    assert {:ok, result} = BoxScore.get(game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "returns empty for unknown (or upcoming) game ID" do
    invalid_id = "99_999_999"
    assert {:ok, result} = BoxScore.get(invalid_id)
    assert result == %{} or result == nil or map_size(result) == 0
  end

  @tag :unit
  test "handles invalid input type gracefully" do
    assert {:error, "Invalid game_id: must be a string or numeric string"} =
             BoxScore.get(true)
  end
end
