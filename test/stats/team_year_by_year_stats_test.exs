defmodule NBA.Stats.TeamYearByYearStatsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamYearByYearStats

  @valid_params [
    TeamID: 1_610_612_744,
    LeagueID: "00",
    PerMode: "Totals",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    TeamID: "foo",
    LeagueID: 0,
    PerMode: "Invalid",
    SeasonType: "Invalid"
  ]

  @unknown_params [
    TeamID: 1_610_612_744,
    RandomParam: "invalid"
  ]

  describe "get/1" do
    test "returns year-by-year stats with valid parameters" do
      assert {:ok, resp} = TeamYearByYearStats.get(@valid_params)
      assert is_map(resp)
    end

    test "get!/1 returns year-by-year stats with valid parameters" do
      assert response = TeamYearByYearStats.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required TeamID" do
      assert {:error, _} = TeamYearByYearStats.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = TeamYearByYearStats.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = TeamYearByYearStats.get(@unknown_params)
    end
  end
end
