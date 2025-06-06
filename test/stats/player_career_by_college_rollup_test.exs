defmodule NBA.Stats.PlayerCareerByCollegeRollupTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerCareerByCollegeRollup

  @valid_params [
    LeagueID: "00",
    PerMode: "Totals",
    SeasonType: "Regular Season",
    Season: "2024-25"
  ]

  @invalid_params [
    # LeagueID should be string from valueset
    LeagueID: 0,
    # PerMode should be string from valueset
    PerMode: "PerMonth",
    # SeasonType should match valueset
    SeasonType: "Season",
    # Season should be string or nil
    Season: 202_425
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    PerMode: "Totals",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns player career by college rollup data with valid parameters" do
      assert {:ok, response} = PlayerCareerByCollegeRollup.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player career by college rollup data with valid parameters" do
      assert response = PlayerCareerByCollegeRollup.get!(@valid_params)
      assert is_map(response)
    end

    test "no required parameters" do
      assert {:ok, response} = PlayerCareerByCollegeRollup.get([])
      assert is_map(response)
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerCareerByCollegeRollup.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerCareerByCollegeRollup.get(@unknown_params)
    end
  end
end
