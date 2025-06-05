defmodule NBA.Stats.LeagueDashPlayerPtShotTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPlayerPtShot

  @valid_params [
    CloseDefDistRange: "",
    College: "",
    Conference: "",
    Country: "",
    DateFrom: "",
    DateTo: "",
    Division: "",
    DraftPick: "",
    DraftYear: "",
    DribbleRange: "",
    GameScope: "",
    GameSegment: "",
    Height: "",
    LastNGames: 0,
    LeagueID: "00",
    Location: "",
    Month: 0,
    OpponentTeamID: 0,
    Outcome: "",
    PORound: 0,
    PerMode: "Totals",
    Period: 0,
    PlayerExperience: "",
    PlayerPosition: "",
    Season: "2024-25",
    SeasonSegment: "",
    SeasonType: "Regular Season",
    ShotClockRange: "",
    StarterBench: "",
    TeamID: 0,
    TouchTimeRange: "",
    VsConference: "",
    VsDivision: "",
    Weight: ""
  ]

  @invalid_params [
    CloseDefDistRange: 123,
    LastNGames: "zero",
    PerMode: :totals,
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player pt shot stats with valid parameters" do
      assert {:ok, response} = LeagueDashPlayerPtShot.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player pt shot stats with valid parameters" do
      assert response = LeagueDashPlayerPtShot.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPlayerPtShot.get()
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPlayerPtShot.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPlayerPtShot.get(@unknown_params)
    end
  end
end
