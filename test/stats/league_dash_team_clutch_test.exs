defmodule NBA.Stats.LeagueDashTeamClutchTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashTeamClutch

  @valid_params [
    MeasureType: "Base",
    PerMode: "PerGame",
    PlusMinus: "Y",
    PaceAdjust: "Y",
    Rank: "Y",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
    Month: 0,
    OpponentTeamID: 0,
    TeamID: 0,
    Period: 0,
    LastNGames: 0,
    ClutchTime: "Last 5 Minutes",
    AheadBehind: "Ahead or Behind",
    PointDiff: 5,
    Season: "2024-25"
  ]

  @invalid_params [
    # expecting string
    ClutchTime: 5,
    # expecting string
    AheadBehind: 123,
    # expecting integer
    PointDiff: "five",
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns team clutch stats with valid parameters" do
      assert {:ok, response} = LeagueDashTeamClutch.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team clutch stats with valid parameters" do
      assert response = LeagueDashTeamClutch.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashTeamClutch.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashTeamClutch.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashTeamClutch.get(@unknown_params)
    end
  end
end
