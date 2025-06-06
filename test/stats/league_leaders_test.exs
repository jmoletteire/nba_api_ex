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
  test "#1) fetches all-time leaders data" do
    assert {:ok, result} = LeagueLeaders.get(Scope: "RS", Season: "2024-25")
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "PLAYER_ID")
    # IO.inspect(hd(result), limit: :infinity, label: "League Leaders Data")
  end

  @tag :integration
  test "test bang function" do
    assert result = LeagueLeaders.get!()
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "PLAYER_ID")
  end

  @tag :unit
  test "#2) handles invalid params" do
    assert {:error, "Parameters and Options must be keyword lists or nil"} =
             LeagueLeaders.get("invalid")
  end

  @tag :unit
  test "#3) handles invalid opts" do
    assert {:error, "Parameters and Options must be keyword lists or nil"} =
             LeagueLeaders.get([], "invalid")
  end

  @tag :unit
  test "#4) rejects unknown param with invalid type" do
    assert {:error, "Invalid parameter(s): :SomeWeirdParam"} =
             LeagueLeaders.get(SomeWeirdParam: :invalid)
  end

  @tag :unit
  test "#5) rejects non-string LeagueID" do
    assert {:error, "Invalid type for LeagueID: got 123, accepts string"} =
             LeagueLeaders.get(LeagueID: 123, PerMode: "PerGame", StatCategory: "PTS")
  end

  @tag :unit
  test "#6) rejects non-string PerMode" do
    assert {:error, "Invalid type for PerMode: got :invalid, accepts string"} =
             LeagueLeaders.get(LeagueID: "00", PerMode: :invalid, StatCategory: "PTS")
  end

  @tag :unit
  test "#7) rejects non-string StatCategory" do
    assert {:error, "Invalid type for StatCategory: got :invalid, accepts string"} =
             LeagueLeaders.get(LeagueID: "00", PerMode: "PerGame", StatCategory: :invalid)
  end

  @tag :unit
  test "#8) rejects non-string Season" do
    assert {:error, "Invalid type for Season: got 2023, accepts string"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               Season: 2023
             )
  end

  @tag :unit
  test "#9) rejects non-string SeasonType" do
    assert {:error, "Invalid type for SeasonType: got :invalid, accepts string"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               SeasonType: :invalid
             )
  end

  @tag :unit
  test "#10) rejects non-string Scope" do
    assert {:error, "Invalid type for Scope: got :invalid, accepts string"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               Scope: :invalid
             )
  end

  @tag :unit
  test "#11) rejects non-string ActiveFlag" do
    assert {:error, "Invalid type for ActiveFlag: got :invalid, accepts string"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               ActiveFlag: :invalid
             )
  end

  @tag :unit
  test "#12) accepts all valid parameters with correct types" do
    assert {:ok, _result} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "Totals",
               StatCategory: "PTS",
               Season: "All Time",
               SeasonType: "Regular Season",
               Scope: "S",
               ActiveFlag: "No"
             )
  end
end
