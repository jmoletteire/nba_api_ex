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
  test "#1) fetches boxscore data for a known game" do
    assert {:ok, result} = BoxScore.get(GameID: "0042400311")
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "test bang function" do
    assert result = BoxScore.get!(GameID: "0042400311")
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#2) returns empty for nonexistent (or upcoming) game ID" do
    assert {:ok, result} = BoxScore.get(GameID: "99_999_999")
    assert result == %{} or result == nil or map_size(result) == 0
  end

  @tag :unit
  test "#3) handles invalid input type gracefully" do
    assert {:error, "Invalid type for GameID: got true, accepts string"} =
             BoxScore.get(GameID: true)
  end

  @tag :unit
  test "#4) handles missing GameID parameter" do
    assert {:error, "Parameters and Options must be keyword lists or nil"} = BoxScore.get(%{})
  end

  @tag :unit
  test "#5) handles empty GameID parameter" do
    assert {:ok, %{}} = BoxScore.get(GameID: "")
  end

  @tag :unit
  test "#6) handles nil GameID parameter" do
    assert {:error, "Missing required parameter(s): :GameID"} = BoxScore.get(GameID: nil)
  end

  @tag :unit
  test "#7) handles invalid GameID format" do
    assert {:error, "Invalid type for GameID: got 123, accepts string"} =
             BoxScore.get(GameID: 123)
  end
end
