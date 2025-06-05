defmodule NBA.Stats.LeagueSeasonMatchupsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueSeasonMatchups

  @valid_params [
    LeagueID: "00",
    PerMode: "PerGame",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    # should be string
    LeagueID: 0,
    # not in valueset
    PerMode: "PerQuarter",
    # should be string in pattern
    Season: 202_425,
    # not in valueset
    SeasonType: "Season",
    # should be integer or NBA team string
    OffTeamID: "not_a_team_id",
    # should be integer or NBA player string
    OffPlayerID: "not_a_player_id",
    # should be integer or NBA team string
    DefTeamID: "not_a_team_id",
    # should be integer or NBA player string
    DefPlayerID: "not_a_player_id"
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    PerMode: "PerGame",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns league season matchup data with valid parameters" do
      assert {:ok, response} = LeagueSeasonMatchups.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league season matchup data with valid parameters" do
      assert response = LeagueSeasonMatchups.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueSeasonMatchups.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueSeasonMatchups.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueSeasonMatchups.get(@unknown_params)
    end
  end
end
