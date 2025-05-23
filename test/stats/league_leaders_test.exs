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
    assert {:ok, result} = LeagueLeaders.get()
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "PLAYER_ID")
  end

  @tag :unit
  test "#2) handles invalid params" do
    assert {:error, "Invalid params: must be a keyword list"} =
             LeagueLeaders.get("invalid")

    assert {:error, "Invalid params: must be a keyword list"} = LeagueLeaders.get(123)
  end

  @tag :unit
  test "#3) handles invalid opts" do
    assert {:error, "Invalid opts: must be a keyword list"} =
             LeagueLeaders.get([], "invalid")

    assert {:error, "Invalid opts: must be a keyword list"} = LeagueLeaders.get([], 123)
  end

  @tag :unit
  test "#4) rejects unknown param with invalid type" do
    assert {:error, "Invalid type for :SomeWeirdParam"} =
             LeagueLeaders.get(SomeWeirdParam: :invalid)
  end

  @tag :unit
  test "#5) rejects non-string LeagueID" do
    assert {:error, "Invalid type for :LeagueID"} =
             LeagueLeaders.get(LeagueID: 123, PerMode: "PerGame", StatCategory: "PTS")
  end

  @tag :unit
  test "#6) rejects non-string PerMode" do
    assert {:error, "Invalid type for :PerMode"} =
             LeagueLeaders.get(LeagueID: "00", PerMode: :invalid, StatCategory: "PTS")
  end

  @tag :unit
  test "#7) rejects non-string StatCategory" do
    assert {:error, "Invalid type for :StatCategory"} =
             LeagueLeaders.get(LeagueID: "00", PerMode: "PerGame", StatCategory: :invalid)
  end

  @tag :unit
  test "#8) rejects non-string Season" do
    assert {:error, "Invalid type for :Season"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               Season: 2023
             )
  end

  @tag :unit
  test "#9) rejects non-string SeasonType" do
    assert {:error, "Invalid type for :SeasonType"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               SeasonType: :invalid
             )
  end

  @tag :unit
  test "#10) rejects non-string Scope" do
    assert {:error, "Invalid type for :Scope"} =
             LeagueLeaders.get(
               LeagueID: "00",
               PerMode: "PerGame",
               StatCategory: "PTS",
               Scope: :invalid
             )
  end

  @tag :unit
  test "#11) rejects non-string ActiveFlag" do
    assert {:error, "Invalid type for :ActiveFlag"} =
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
