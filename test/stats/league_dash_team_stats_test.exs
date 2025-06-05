defmodule NBA.Stats.LeagueDashTeamStatsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashTeamStats

  @invalid_params [
    LeagueID: "invalid",
    Season: "2024-25"
  ]
  @unknown_params [
    Invalid: "00",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns league dash team stats data with default parameters" do
      assert {:ok, _response} = LeagueDashTeamStats.get(Season: "2024-25")
    end

    test "get!/2 returns league dash team stats data with default parameters" do
      assert response = LeagueDashTeamStats.get!(Season: "2024-25")
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season"} = LeagueDashTeamStats.get()
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = LeagueDashTeamStats.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = LeagueDashTeamStats.get(@unknown_params)
    end
  end
end
