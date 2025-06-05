defmodule NBA.Stats.PlayByPlayTest do
  use ExUnit.Case
  alias NBA.Stats.PlayByPlay
  alias NBA.Stats.PlayByPlayV2
  alias NBA.Stats.PlayByPlayV3

  @valid_params [
    GameID: "0022400061",
    StartPeriod: 1,
    EndPeriod: 4
  ]

  @invalid_params [
    # GameID should be string matching ^\d{10}$
    GameID: "BADID",
    StartPeriod: "first",
    EndPeriod: "last"
  ]

  @unknown_params [
    RandomParam: "invalid",
    GameID: "0022400061"
  ]

  describe "get/2" do
    test "returns play by play data with valid parameters" do
      assert {:ok, response} = PlayByPlay.get(@valid_params)
      assert is_map(response)
    end

    test "returns play by play data v2 with valid parameters" do
      assert {:ok, response} = PlayByPlayV2.get(@valid_params)
      assert is_map(response)
    end

    test "returns play by play data v3 with valid parameters" do
      assert {:ok, response} = PlayByPlayV3.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns play by play data with valid parameters" do
      assert response = PlayByPlay.get!(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns play by play v2 data with valid parameters" do
      assert response = PlayByPlayV2.get!(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns play by play v3 data with valid parameters" do
      assert response = PlayByPlayV3.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GameID" <> _} =
               PlayByPlay.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayByPlay.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayByPlay.get(@unknown_params)
    end
  end
end
