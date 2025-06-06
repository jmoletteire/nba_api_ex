defmodule NBA.Stats.TeamEstimatedMetricsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamEstimatedMetrics

  @valid_params [
    Season: "2024-25",
    LeagueID: "00",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    Season: 202_425,
    LeagueID: 0,
    SeasonType: 123
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns team estimated metrics data with valid parameters" do
      assert {:ok, response} = TeamEstimatedMetrics.get(@valid_params)
      assert is_list(response)
    end

    test "get!/2 returns team estimated metrics data with valid parameters" do
      assert response = TeamEstimatedMetrics.get!(@valid_params)
      assert is_list(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               TeamEstimatedMetrics.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamEstimatedMetrics.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamEstimatedMetrics.get(@unknown_params)
    end
  end
end
