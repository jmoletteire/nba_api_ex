defmodule NBA.Stats.PlayerEstimatedMetricsTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerEstimatedMetrics

  @valid_params [
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    LeagueID: 0,
    Season: 202_425,
    SeasonType: 123
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns player estimated metrics data with valid parameters" do
      assert {:ok, response} = PlayerEstimatedMetrics.get(@valid_params)
      assert is_list(response)
    end

    test "get!/2 returns player estimated metrics data with valid parameters" do
      assert response = PlayerEstimatedMetrics.get!(@valid_params)
      assert is_list(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               PlayerEstimatedMetrics.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerEstimatedMetrics.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerEstimatedMetrics.get(@unknown_params)
    end
  end
end
