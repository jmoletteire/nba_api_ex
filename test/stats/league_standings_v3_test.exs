defmodule NBA.Stats.LeagueStandingsV3Test do
  use ExUnit.Case
  alias NBA.Stats.LeagueStandingsV3

  @valid_params [
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    # should be string
    LeagueID: 0,
    # should be string
    Season: 202_425,
    # not in valueset
    SeasonType: "Season"
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns league standings v3 data with valid parameters" do
      assert {:ok, response} = LeagueStandingsV3.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league standings v3 data with valid parameters" do
      assert response = LeagueStandingsV3.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueStandingsV3.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueStandingsV3.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueStandingsV3.get(@unknown_params)
    end
  end
end
