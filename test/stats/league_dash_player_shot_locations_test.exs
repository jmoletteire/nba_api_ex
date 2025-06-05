defmodule NBA.Stats.LeagueDashPlayerShotLocationsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashPlayerShotLocations

  @valid_params [Season: "2024-25"]

  @invalid_params [
    # expecting string
    Conference: 123,
    # expecting string
    DistanceRange: 5,
    # expecting integer
    LastNGames: "ten",
    # expecting string
    LeagueID: 0,
    Season: "2024-25"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player shot locations stats with valid parameters" do
      assert {:ok, response} = LeagueDashPlayerShotLocations.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player shot locations stats with valid parameters" do
      assert response = LeagueDashPlayerShotLocations.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashPlayerShotLocations.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashPlayerShotLocations.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashPlayerShotLocations.get(@unknown_params)
    end
  end
end
