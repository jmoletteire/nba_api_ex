defmodule NBA.Stats.PlayerCareerStatsTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerCareerStats

  @valid_params [
    PerMode: "Totals",
    PlayerID: 201_939,
    LeagueID: "00"
  ]

  @invalid_params [
    # PerMode should be string from valueset
    PerMode: "PerMonth",
    # PlayerID should be integer or string
    PlayerID: :not_an_id,
    # LeagueID should be string or nil
    LeagueID: 0
  ]

  @unknown_params [
    RandomParam: "invalid",
    PerMode: "Totals",
    PlayerID: 201_939
  ]

  describe "get/2" do
    test "returns player career stats data with valid parameters" do
      assert {:ok, response} = PlayerCareerStats.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player career stats data with valid parameters" do
      assert response = PlayerCareerStats.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID" <> _} =
               PlayerCareerStats.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerCareerStats.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerCareerStats.get(@unknown_params)
    end
  end
end
