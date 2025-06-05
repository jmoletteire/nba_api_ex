defmodule NBA.Stats.LeagueHustleStatsTeamTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueHustleStatsTeam

  @valid_params [
    PerMode: "PerGame",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    # not in valueset
    PerMode: "PerQuarter",
    # should be string
    Season: 202_425,
    # not in valueset
    SeasonType: "Season",
    # should be integer or NBA team string
    TeamID: "not_a_team_id",
    # should be integer
    Month: "January"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    PerMode: "PerGame",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns league hustle stats team data with valid parameters" do
      assert {:ok, response} = LeagueHustleStatsTeam.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league hustle stats team data with valid parameters" do
      assert response = LeagueHustleStatsTeam.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueHustleStatsTeam.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueHustleStatsTeam.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueHustleStatsTeam.get(@unknown_params)
    end
  end
end
