defmodule NBA.Stats.LeagueDashTeamShotLocationsTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueDashTeamShotLocations

  @valid_params [
    PerMode: "PerGame",
    LeagueID: "00",
    SeasonType: "Regular Season",
    PORound: 0,
    Month: 0,
    OpponentTeamID: 0,
    TeamID: 0,
    Period: 0,
    LastNGames: 0,
    DistanceRange: "By Zone",
    Season: "2024-25"
  ]

  @invalid_params [
    # expecting string
    DistanceRange: 123,
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
    test "returns team shot locations stats with valid parameters" do
      assert {:ok, response} = LeagueDashTeamShotLocations.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team shot locations stats with valid parameters" do
      assert response = LeagueDashTeamShotLocations.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueDashTeamShotLocations.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueDashTeamShotLocations.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueDashTeamShotLocations.get(@unknown_params)
    end
  end
end
