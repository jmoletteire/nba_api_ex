defmodule NBA.Stats.TeamInfoCommonTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamInfoCommon

  @valid_params [
    TeamID: 1_610_612_737,
    LeagueID: "00",
    SeasonType: "Regular Season",
    Season: "2022-23"
  ]

  @invalid_params [
    TeamID: "foo",
    LeagueID: 0,
    SeasonType: "INVALID",
    Season: 202223
  ]

  @unknown_params [
    TeamID: 1_610_612_737,
    RandomParam: "invalid"
  ]

  describe "get/1" do
    test "returns team info with valid parameters" do
      assert {:ok, resp} = TeamInfoCommon.get(@valid_params)
      assert is_map(resp)
    end

    test "returns error for missing required TeamID" do
      assert {:error, _} = TeamInfoCommon.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = TeamInfoCommon.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = TeamInfoCommon.get(@unknown_params)
    end

    test "optional parameters can be nil or omitted" do
      params = [TeamID: 1_610_612_737, SeasonType: nil, Season: nil]
      assert {:ok, resp} = TeamInfoCommon.get(params)
      assert is_map(resp)
    end
  end
end
