defmodule NBA.Stats.ShotChartDetailTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.ShotChartDetail

  @valid_params [
    ContextMeasure: "FGA",
    LastNGames: 0,
    LeagueID: "00",
    Month: 0,
    OpponentTeamID: 0,
    Period: 0,
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_737
  ]

  @invalid_params [
    # expecting string from valueset
    ContextMeasure: "INVALID",
    # expecting integer
    LastNGames: "zero",
    # expecting string
    LeagueID: 0,
    # expecting integer
    Month: "one",
    # expecting integer or string
    OpponentTeamID: nil,
    # expecting integer
    Period: "first",
    # expecting integer or string
    PlayerID: nil,
    # expecting string from valueset
    SeasonType: "Midseason",
    # expecting integer or string
    TeamID: nil
  ]

  @unknown_params [
    RandomParam: "invalid",
    PlayerID: 201_939
  ]

  describe "get/2" do
    test "returns shot chart detail data with valid parameters" do
      assert {:ok, response} = ShotChartDetail.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns shot chart detail data with valid parameters" do
      assert response = ShotChartDetail.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID" <> _} =
               ShotChartDetail.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = ShotChartDetail.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = ShotChartDetail.get(@unknown_params)
    end
  end
end
