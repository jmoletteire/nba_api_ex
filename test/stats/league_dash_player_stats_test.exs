defmodule NBA.Stats.LeagueDashPlayerStatsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPlayerStats

  @valid_params [
    College: "",
    Conference: "West",
    Country: "",
    DateFrom: "",
    DateTo: "",
    Division: "Pacific",
    DraftPick: "",
    DraftYear: "",
    GameScope: "",
    GameSegment: "",
    Height: "",
    LastNGames: 0,
    LeagueID: "00",
    Location: "",
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    Outcome: "",
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerExperience: "",
    PlayerPosition: "",
    PlusMinus: "N",
    PORound: 0,
    Rank: "N",
    Season: "2024-25",
    SeasonSegment: "",
    SeasonType: "Regular Season",
    ShotClockRange: "",
    StarterBench: "",
    TeamID: 0,
    VsConference: "",
    VsDivision: "",
    Weight: ""
  ]

  @invalid_params [
    # expecting string
    Conference: 123,
    # expecting integer
    LastNGames: "ten",
    # expecting string
    LeagueID: 0,
    # expecting string
    MeasureType: 5,
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player stats with valid parameters" do
      assert {:ok, response} = LeagueDashPlayerStats.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player stats with valid parameters" do
      assert response = LeagueDashPlayerStats.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPlayerStats.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPlayerStats.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPlayerStats.get(@unknown_params)
    end
  end
end
