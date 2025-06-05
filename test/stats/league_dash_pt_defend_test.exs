defmodule NBA.Stats.LeagueDashPtDefendTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPtDefend

  @valid_params [
    PerMode: "PerGame",
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season",
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
    DefenseCategory: "Overall",
    ISTRound: nil
  ]

  @invalid_params [
    DefenseCategory: 5,        # expecting string
    Conference: 123,           # expecting string
    LastNGames: "ten",         # expecting integer
    LeagueID: 0,               # expecting string
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    DefenseCategory: "Overall"
  ]

  describe "get/2" do
    test "returns player tracking defend stats with valid parameters" do
      assert {:ok, response} = LeagueDashPtDefend.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player tracking defend stats with valid parameters" do
      assert response = LeagueDashPtDefend.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPtDefend.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPtDefend.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPtDefend.get(@unknown_params)
    end
  end
end