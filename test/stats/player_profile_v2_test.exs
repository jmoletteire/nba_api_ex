defmodule NBA.Stats.PlayerProfileV2Test do
  use ExUnit.Case, async: true
  alias NBA.Stats.PlayerProfileV2

  @valid_params [
    PerMode: "PerGame",
    PlayerID: 201_939,
    LeagueID: "00"
  ]

  @invalid_params [
    # expecting String
    LeagueID: "201939"
  ]

  @unknown_params [
    RandomParam: "invalid",
    PlayerID: 201_939
  ]

  describe "get/2" do
    test "returns player profile data with valid parameters" do
      assert {:ok, response} = PlayerProfileV2.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player profile data with valid parameters" do
      assert response = PlayerProfileV2.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID" <> _} =
               PlayerProfileV2.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerProfileV2.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerProfileV2.get(@unknown_params)
    end
  end
end
