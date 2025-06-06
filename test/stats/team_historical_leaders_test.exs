defmodule NBA.Stats.TeamHistoricalLeadersTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamHistoricalLeaders

  @valid_params [
    LeagueID: "00",
    SeasonID: "22015",
    TeamID: 1_610_612_744
  ]

  @invalid_params [
    LeagueID: 0,
    SeasonID: 2015,
    TeamID: "foo"
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    SeasonID: "22015",
    TeamID: 1_610_612_744
  ]

  describe "get/2" do
    test "returns team historical leaders data with valid parameters" do
      assert {:ok, response} = TeamHistoricalLeaders.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team historical leaders data with valid parameters" do
      assert response = TeamHistoricalLeaders.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :SeasonID, :TeamID" <> _} =
               TeamHistoricalLeaders.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamHistoricalLeaders.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamHistoricalLeaders.get(@unknown_params)
    end
  end
end
