defmodule NBA.Live.PBPTest do
  use ExUnit.Case
  alias NBA.Live.PBP

  @moduledoc """
  Tests for the NBA.Live.PBP module.
  You can run these tests using any of these commands:
  - mix test test/live/pbp_test.exs
  - mix test test/live/pbp_test.exs:{line_number}
  - mix test test/live/pbp_test.exs --only integration
  - mix test test/live/pbp_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching play-by-play data for a known game (e.g., game ID "0042400311").
  - Fetching play-by-play data for an unknown game ID.
  - Handling invalid input types (non-string game ID).
  """

  @tag :integration
  test "#1) fetches play-by-play data for a known game" do
    assert {:ok, result} = PBP.get(GameID: "0042400311")
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "test bang function" do
    assert result = PBP.get!(GameID: "0042400311")
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#2) returns empty for unknown (or upcoming) game ID" do
    assert {:ok, result} = PBP.get(GameID: "99_999_999")
    assert result == %{} or result == nil or map_size(result) == 0
  end

  @tag :unit
  test "#3) handles invalid input type gracefully" do
    assert {:error, "Parameters and Options must be keyword lists or nil"} =
             PBP.get(true)
  end

  @tag :unit
  test "#4) handles missing GameID parameter" do
    assert {:error, "Parameters and Options must be keyword lists or nil"} = PBP.get(%{})
  end

  @tag :unit
  test "#5) handles empty GameID parameter" do
    assert {:ok, %{}} = PBP.get(GameID: "")
  end

  @tag :unit
  test "#6) handles nil GameID parameter" do
    assert {:error, "Missing required parameter(s): :GameID"} = PBP.get(GameID: nil)
  end

  @tag :unit
  test "#7) handles invalid GameID format" do
    assert {:error, "Invalid type for GameID: got 123, accepts string"} =
             PBP.get(GameID: 123)
  end
end
