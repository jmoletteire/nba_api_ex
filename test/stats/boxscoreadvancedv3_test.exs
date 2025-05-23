defmodule NBA.Stats.BoxScoreAdvancedV3Test do
  use ExUnit.Case
  alias NBA.Stats.BoxScoreAdvancedV3

  @moduledoc """
  Tests for the NBA.Stats.BoxScoreAdvancedV3 module.
  You can run these tests using any of these commands:
  - mix test test/stats/boxscoreadvancedv3_test.exs
  - mix test test/stats/boxscoreadvancedv3_test.exs:{line_number}
  - mix test test/stats/boxscoreadvancedv3_test.exs --only integration
  - mix test test/stats/boxscoreadvancedv3_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching advanced box score data for a known game (e.g., game ID "0022200001").
  - Fetching advanced box score data for an unknown game ID.
  - Handling invalid input types (non-string game ID).
  """

  @tag :integration
  test "#1) fetches advanced box score data" do
    game_id = "0042400301"
    assert {:ok, result} = BoxScoreAdvancedV3.get(GameID: game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#2) returns 400 error for unknown game ID" do
    invalid_id = "99_999_999"

    assert {:error, "Bad request (400). Check your query parameters."} =
             BoxScoreAdvancedV3.get(GameID: invalid_id)
  end

  @tag :integration
  test "#3) not keyword list" do
    assert {:error, "Invalid options: must be a keyword list"} =
             BoxScoreAdvancedV3.get("invalid")
  end

  @tag :integration
  test "#4) no game id" do
    assert {:error, "Missing required parameter :GameID"} =
             BoxScoreAdvancedV3.get(
               LeagueID: "00",
               endPeriod: 0,
               endRange: 31800,
               rangeType: 0,
               startPeriod: 0,
               startRange: 0
             )
  end

  @tag :unit
  test "#5) rejects unknown param with invalid type" do
    assert {:error, "Invalid type for :SomeWeirdParam"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", SomeWeirdParam: :invalid)
  end

  @tag :unit
  test "#6) rejects non-string GameID" do
    assert {:error, "Invalid type for :GameID"} =
             BoxScoreAdvancedV3.get(GameID: 123)
  end

  @tag :unit
  test "#7) rejects non-string LeagueID" do
    assert {:error, "Invalid type for :LeagueID"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", LeagueID: 123)
  end

  @tag :unit
  test "#8) rejects non-integer endPeriod" do
    assert {:error, "Invalid type for :endPeriod"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", EndPeriod: "last")
  end

  @tag :unit
  test "#9) rejects non-integer endRange" do
    assert {:error, "Invalid type for :endRange"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", EndRange: "infinity")
  end

  @tag :unit
  test "#10) rejects non-integer rangeType" do
    assert {:error, "Invalid type for :rangeType"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", RangeType: "all")
  end

  @tag :unit
  test "#11) rejects non-integer startPeriod" do
    assert {:error, "Invalid type for :startPeriod"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", StartPeriod: "first")
  end

  @tag :unit
  test "#12) rejects non-integer startRange" do
    assert {:error, "Invalid type for :startRange"} =
             BoxScoreAdvancedV3.get(GameID: "0042400301", StartRange: "zero")
  end

  @tag :unit
  test "#13) accepts all valid parameters with correct types" do
    assert {:ok, _result} =
             BoxScoreAdvancedV3.get(
               GameID: "0042400301",
               LeagueID: "00",
               startPeriod: 1,
               endPeriod: 4,
               startRange: 0,
               endRange: 28800,
               rangeType: 0
             )
  end
end
