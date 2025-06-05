defmodule NBA.Stats.LeagueDashPtStatsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPtStats

  @valid_params [
    PerMode: "PerGame",
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season",
    PtMeasureType: "Possessions",
    PORound: 0,
    PlayerID: nil,
    TeamID: 0,
    Outcome: nil,
    Location: nil,
    Month: 0,
    SeasonSegment: nil,
    DateFrom: nil,
    DateTo: nil,
    OpponentTeamID: 0,
    VsConference: nil,
    VsDivision: nil,
    Conference: nil,
    Division: nil,
    GameSegment: nil,
    Period: 0,
    LastNGames: 0,
    DraftYear: nil,
    DraftPick: nil,
    College: nil,
    Country: nil,
    Height: nil,
    Weight: nil,
    PlayerExperience: nil,
    PlayerPosition: nil,
    StarterBench: nil,
    DribbleRange: nil,
    ShotClockRange: nil,
    TouchTimeRange: nil,
    ISTRound: nil
  ]

  @invalid_params [
    # expecting string
    PerMode: 123,
    # expecting integer
    LastNGames: "ten",
    # expecting string
    LeagueID: 0,
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player tracking shot stats with valid parameters" do
      assert {:ok, response} = LeagueDashPtStats.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player tracking shot stats with valid parameters" do
      assert response = LeagueDashPtStats.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPtStats.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPtStats.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPtStats.get(@unknown_params)
    end
  end
end
