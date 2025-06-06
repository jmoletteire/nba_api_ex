defmodule NBA.Stats.SynergyPlayTypesTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.SynergyPlayTypes

  @valid_params [
    LeagueID: "00",
    PerMode: "PerGame",
    PlayerOrTeam: "P",
    SeasonType: "Regular Season",
    SeasonYear: "2024-25"
  ]

  @invalid_params [
    # expecting string from valueset
    PerMode: "Per48",
    # expecting string from valueset
    PlayerOrTeam: "X",
    # expecting string from valueset
    SeasonType: "Midseason",
    # expecting string
    SeasonYear: 202_425
  ]

  @unknown_params [
    RandomParam: "invalid",
    PerMode: "PerGame"
  ]

  describe "get/2" do
    test "returns synergy play types data with valid parameters" do
      assert {:ok, response} = SynergyPlayTypes.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns synergy play types data with valid parameters" do
      assert response = SynergyPlayTypes.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error,
              "Missing required parameter(s): :SeasonYear" <>
                _} =
               SynergyPlayTypes.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = SynergyPlayTypes.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = SynergyPlayTypes.get(@unknown_params)
    end

    test "LeagueID is optional and defaults to '00' if not provided" do
      params = Keyword.delete(@valid_params, :LeagueID)
      assert {:ok, response} = SynergyPlayTypes.get(params)
      assert is_map(response)
    end
  end
end
