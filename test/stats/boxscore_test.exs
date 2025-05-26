defmodule NBA.Stats.BoxScoreTest do
  use ExUnit.Case
  alias NBA.Stats.BoxScore

  @moduledoc """
  Tests for the NBA.Stats.BoxScore module.
  You can run these tests using any of these commands:
  - mix test test/stats/boxscore_test.exs
  - mix test test/stats/boxscore_test.exs:{line_number}
  - mix test test/stats/boxscore_test.exs --only integration
  - mix test test/stats/boxscore_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching advanced box score data for a known game (e.g., game ID "0022200001").
  - Fetching advanced box score data for an unknown game ID.
  - Handling invalid input types (non-string game ID).
  """

  @game_id "0042400301"

  @tag :integration
  test "#1) fetches box score data" do
    assert {:ok, result} = BoxScore.get(:traditional, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#2) returns 400 error for unknown game ID" do
    assert {:error, "Bad request (400). Check your query parameters."} =
             BoxScore.get(:traditional, GameID: "99_999_999")
  end

  @tag :integration
  test "#3) invalid parameters: not keyword list" do
    assert {:error, "Invalid parameters: must be a keyword list"} =
             BoxScore.get(:traditional, "invalid", [])
  end

  @tag :integration
  test "#4) invalid options: not keyword list" do
    assert {:error, "Invalid options: must be a keyword list"} =
             BoxScore.get(:traditional, [GameID: @game_id], "invalid")
  end

  @tag :integration
  test "#5) no game id" do
    assert {:error, "Missing required parameter :GameID"} =
             BoxScore.get(
               :traditional,
               LeagueID: "00",
               endPeriod: 0,
               endRange: 31800,
               rangeType: 0,
               startPeriod: 0,
               startRange: 0
             )
  end

  @tag :integration
  test "#6) fetches traditional box score data" do
    assert {:ok, result} = BoxScore.get(:traditional, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#7) fetches advanced box score data" do
    assert {:ok, result} = BoxScore.get(:advanced, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#8) fetches misc box score data" do
    assert {:ok, result} = BoxScore.get(:misc, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#9) fetches scoring box score data" do
    assert {:ok, result} = BoxScore.get(:scoring, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#10) fetches usage box score data" do
    assert {:ok, result} = BoxScore.get(:usage, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#11) fetches four factors box score data" do
    assert {:ok, result} = BoxScore.get(:fourfactors, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#12) fetches hustle box score data" do
    assert {:ok, result} = BoxScore.get(:hustle, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#13) fetches defense box score data" do
    assert {:ok, result} = BoxScore.get(:defense, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#14) fetches matchups box score data" do
    assert {:ok, result} = BoxScore.get(:matchups, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "gameId")
  end

  @tag :integration
  test "#15) fetches summary box score data" do
    assert {:ok, result} = BoxScore.get(:summary, GameID: @game_id)
    assert is_map(result)
    assert Map.has_key?(result, "GameSummary")
  end

  @tag :integration
  test "#15) rejects unknown box score type" do
    assert {:error,
            "Invalid box score type :invalid — valid types are usage, traditional, advanced, misc, scoring, fourfactors, hustle, defense, matchups, summary"} =
             BoxScore.get(:invalid, GameID: @game_id)
  end

  @tag :unit
  test "#16) rejects unknown param with invalid type" do
    assert {:error, "Invalid type for :SomeWeirdParam"} =
             BoxScore.get(:traditional, GameID: @game_id, SomeWeirdParam: :invalid)
  end

  @tag :unit
  test "#17) rejects non-string GameID" do
    assert {:error, "Invalid type for :GameID"} =
             BoxScore.get(:traditional, GameID: 123)
  end

  @tag :unit
  test "#18) rejects non-string LeagueID" do
    assert {:error, "Invalid type for :LeagueID"} =
             BoxScore.get(:traditional, GameID: @game_id, LeagueID: 123)
  end

  @tag :unit
  test "#19) rejects non-integer endPeriod" do
    assert {:error, "Invalid type for :endPeriod"} =
             BoxScore.get(:traditional, GameID: @game_id, endPeriod: "last")
  end

  @tag :unit
  test "#20) rejects non-integer endRange" do
    assert {:error, "Invalid type for :endRange"} =
             BoxScore.get(:traditional, GameID: @game_id, endRange: "infinity")
  end

  @tag :unit
  test "#21) rejects non-integer rangeType" do
    assert {:error, "Invalid type for :rangeType"} =
             BoxScore.get(:traditional, GameID: @game_id, rangeType: "all")
  end

  @tag :unit
  test "#22) rejects non-integer startPeriod" do
    assert {:error, "Invalid type for :startPeriod"} =
             BoxScore.get(:traditional, GameID: @game_id, startPeriod: "first")
  end

  @tag :unit
  test "#23) rejects non-integer startRange" do
    assert {:error, "Invalid type for :startRange"} =
             BoxScore.get(:traditional, GameID: @game_id, startRange: "zero")
  end

  @tag :unit
  test "#24) accepts all valid parameters with correct types" do
    assert {:ok, _result} =
             BoxScore.get(
               :traditional,
               GameID: @game_id,
               LeagueID: "00",
               startPeriod: 1,
               endPeriod: 4,
               startRange: 0,
               endRange: 28800,
               rangeType: 0
             )
  end
end
