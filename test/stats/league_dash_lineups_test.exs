defmodule NBA.Stats.LeagueDashLineupsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashLineups

  @invalid_params [
    LeagueID: "invalid",
    Season: "2023-24"
  ]
  @unknown_params [
    Invalid: "00",
    Season: "2023-24"
  ]

  describe "get/2" do
    test "returns league lineup data with default parameters" do
      assert {:ok, _response} = LeagueDashLineups.get(Season: "2024-25")
    end

    test "get!/2 returns league lineup data with default parameters" do
      assert response = LeagueDashLineups.get!(Season: "2024-25")
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season"} = LeagueDashLineups.get()
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = LeagueDashLineups.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = LeagueDashLineups.get(@unknown_params)
    end
  end
end
