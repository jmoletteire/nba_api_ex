defmodule NBA.Stats.WinProbabilityPBPTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.WinProbabilityPBP

  @valid_params [
    GameID: "0022100001",
    RunType: "single"
  ]

  @invalid_params [
    GameID: 123,
    RunType: 456
  ]

  @unknown_params [
    RandomParam: "invalid",
    GameID: "0022100001",
    RunType: "single"
  ]

  describe "get/2" do
    test "returns win probability pbp data with valid parameters" do
      assert {:ok, response} = WinProbabilityPBP.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns win probability pbp data with valid parameters" do
      assert response = WinProbabilityPBP.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GameID" <> _} =
               WinProbabilityPBP.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = WinProbabilityPBP.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = WinProbabilityPBP.get(@unknown_params)
    end
  end
end
