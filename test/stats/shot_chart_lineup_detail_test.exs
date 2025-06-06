defmodule NBA.Stats.ShotChartLineupDetailTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.ShotChartLineupDetail

  @valid_params [
    ContextMeasure: "PTS",
    GROUP_ID: "1629029 - 1630559 - 1629060 - 1627827 - 2544",
    LeagueID: "00",
    Period: 0,
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    # expecting string from valueset
    ContextMeasure: "INVALID",
    # expecting string
    GROUP_ID: 12345,
    # expecting string
    LeagueID: 0,
    # expecting integer
    Period: "first",
    # expecting string
    Season: 202_425,
    # expecting string from valueset
    SeasonType: "Midseason"
  ]

  @unknown_params [
    RandomParam: "invalid",
    GROUP_ID: "1610612737 - 201939 - 202691 - 203507 - 203954"
  ]

  describe "get/2" do
    test "returns lineup shot chart detail data with valid parameters" do
      assert {:ok, response} = ShotChartLineupDetail.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns lineup shot chart detail data with valid parameters" do
      assert response = ShotChartLineupDetail.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GROUP_ID, :Season" <> _} =
               ShotChartLineupDetail.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = ShotChartLineupDetail.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = ShotChartLineupDetail.get(@unknown_params)
    end
  end
end
