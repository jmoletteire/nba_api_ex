defmodule NBA.Stats.MatchupsRollupTest do
  use ExUnit.Case
  alias NBA.Stats.MatchupsRollup

  @valid_params [
    LeagueID: "00",
    PerMode: "Totals",
    Season: "2024-25",
    SeasonType: "Regular Season",
    OffTeamID: 1_610_612_737,
    OffPlayerID: 201_939,
    DefTeamID: 1_610_612_744,
    DefPlayerID: 202_691
  ]

  @invalid_params [
    # LeagueID should be string matching ^\d{2}$
    LeagueID: 0,
    # PerMode should be string from valueset
    PerMode: "PerMonth",
    # Season should match ^(\d{4}-\d{2})$
    Season: "2024/25",
    # SeasonType should be from valueset
    SeasonType: "Season",
    # IDs should be string, integer, or nil
    OffTeamID: :not_an_id,
    OffPlayerID: :not_an_id,
    DefTeamID: :not_an_id,
    DefPlayerID: :not_an_id
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    PerMode: "Totals",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns matchups rollup data with valid parameters" do
      assert {:ok, response} = MatchupsRollup.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns matchups rollup data with valid parameters" do
      assert response = MatchupsRollup.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               MatchupsRollup.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = MatchupsRollup.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = MatchupsRollup.get(@unknown_params)
    end
  end
end
