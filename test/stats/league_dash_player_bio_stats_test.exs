defmodule NBA.Stats.LeagueDashPlayerBioStatsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPlayerBioStats

  @valid_params [
    LeagueID: "00",
    PerMode: "Totals",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    LeagueID: 123,
    Season: "2024-25"
  ]

  @unknown_params [
    UnknownKey: "value",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player bio stats with valid parameters" do
      assert {:ok, response} = LeagueDashPlayerBioStats.get(@valid_params)
      assert is_map(response)
      IO.inspect(response, label: "LeagueDashPlayerBioStats.get/2 response")
    end

    test "get!/2 returns player bio stats with valid parameters" do
      assert response = LeagueDashPlayerBioStats.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPlayerBioStats.get()
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = LeagueDashPlayerBioStats.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = LeagueDashPlayerBioStats.get(@unknown_params)
    end
  end
end
