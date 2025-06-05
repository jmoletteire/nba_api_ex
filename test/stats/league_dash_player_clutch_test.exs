defmodule NBA.Stats.LeagueDashPlayerClutchTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPlayerClutch

  @valid_params [
    AheadBehind: "Ahead or Behind",
    ClutchTime: "Last 5 Minutes",
    DateFrom: "",
    DateTo: "",
    GameScope: "",
    GameSegment: "",
    LastNGames: 0,
    Location: "",
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    Outcome: "",
    PaceAdjust: "N",
    PerMode: "Totals",
    Period: 0,
    PlayerExperience: "",
    PlayerPosition: "",
    PlusMinus: "N",
    PointDiff: 5,
    Rank: "N",
    Season: "2024-25",
    SeasonSegment: "",
    SeasonType: "Regular Season",
    StarterBench: "",
    VsConference: "",
    VsDivision: ""
  ]

  @invalid_params [
    # expecting string
    AheadBehind: :invalid,
    # expecting string
    ClutchTime: 123,
    # expecting integer
    LastNGames: "five",
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    ClutchTime: "Last 5 Minutes",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player clutch stats with valid parameters" do
      assert {:ok, response} = LeagueDashPlayerClutch.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player clutch stats with valid parameters" do
      assert response = LeagueDashPlayerClutch.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPlayerClutch.get()
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPlayerClutch.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPlayerClutch.get(@unknown_params)
    end
  end
end
