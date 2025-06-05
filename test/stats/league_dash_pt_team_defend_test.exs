defmodule NBA.Stats.LeagueDashPtTeamDefendTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPtTeamDefend

  @valid_params [
    PerMode: "PerGame",
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season",
    PORound: 0,
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
    StarterBench: nil,
    DefenseCategory: "Overall",
    ISTRound: nil
  ]

  @invalid_params [
    # expecting string
    DefenseCategory: 5,
    # expecting integer or NBA team string
    TeamID: "not_a_team_id",
    # expecting integer
    LastNGames: "ten",
    # expecting string
    LeagueID: 0,
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    DefenseCategory: "Overall"
  ]

  describe "get/2" do
    test "returns team tracking defend stats with valid parameters" do
      assert {:ok, response} = LeagueDashPtTeamDefend.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team tracking defend stats with valid parameters" do
      assert response = LeagueDashPtTeamDefend.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPtTeamDefend.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPtTeamDefend.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPtTeamDefend.get(@unknown_params)
    end
  end
end
