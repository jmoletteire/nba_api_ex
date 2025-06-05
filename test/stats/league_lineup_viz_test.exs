defmodule NBA.Stats.LeagueLineupVizTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueLineupViz

  @valid_params [
    GroupQuantity: 5,
    LastNGames: 0,
    MeasureType: "Base",
    MinutesMin: 0,
    Month: 0,
    OpponentTeamID: 0,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    # should be integer
    GroupQuantity: "five",
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
    # should be integer
    MinutesMin: "zero",
    # should be integer
    Month: "January",
    # should be integer or NBA team string
    OpponentTeamID: "not_a_team_id",
    # should be integer
    Period: "first"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    GroupQuantity: 5,
    PerMode: "PerGame",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns league lineup viz data with valid parameters" do
      assert {:ok, response} = LeagueLineupViz.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league lineup viz data with valid parameters" do
      assert response = LeagueLineupViz.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueLineupViz.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueLineupViz.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueLineupViz.get(@unknown_params)
    end
  end
end
