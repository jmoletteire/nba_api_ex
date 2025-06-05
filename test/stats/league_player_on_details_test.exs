defmodule NBA.Stats.LeaguePlayerOnDetailsTest do
  use ExUnit.Case
  alias NBA.Stats.LeaguePlayerOnDetails

  @valid_params [
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_747
  ]

  @invalid_params [
    # should be integer
    LastNGames: "zero",
    # not in valueset
    MeasureType: "Basic",
    # not in valueset
    PerMode: "PerQuarter",
    # not in valueset
    PaceAdjust: "Maybe",
    # not in valueset
    PlusMinus: "Maybe",
    # not in valueset
    Rank: "Maybe",
    # should be string
    Season: 202_425,
    # not in valueset
    SeasonType: "Season",
    # should be integer or NBA team string
    TeamID: "not_a_team_id",
    # should be integer
    Period: "first"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    TeamID: 1_610_612_747
  ]

  describe "get/2" do
    test "returns league player on details data with valid parameters" do
      assert {:ok, response} = LeaguePlayerOnDetails.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league player on details data with valid parameters" do
      assert response = LeaguePlayerOnDetails.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeaguePlayerOnDetails.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeaguePlayerOnDetails.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeaguePlayerOnDetails.get(@unknown_params)
    end
  end
end
