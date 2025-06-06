defmodule NBA.Stats.PlayerGameStreakFinderTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerGameStreakFinder

  @valid_params [
    PlayerID: 201_939,
    Season: "2024-25"
  ]

  @invalid_params [
    # should be string
    LeagueID: 0,
    # should be integer
    PORound: "first"
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00"
  ]

  describe "get/2" do
    test "returns league game finder data with valid parameters" do
      assert {:ok, response} = PlayerGameStreakFinder.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league game finder data with valid parameters" do
      assert response = PlayerGameStreakFinder.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      params = Keyword.delete(@valid_params, :PlayerID)
      assert {:error, _} = PlayerGameStreakFinder.get(params)
      params = Keyword.delete(@valid_params, :Season)
      assert {:error, _} = PlayerGameStreakFinder.get(params)
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerGameStreakFinder.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerGameStreakFinder.get(@unknown_params)
    end
  end
end
