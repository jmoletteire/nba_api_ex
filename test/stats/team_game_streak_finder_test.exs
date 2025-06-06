defmodule NBA.Stats.TeamGameStreakFinderTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamGameStreakFinder

  @valid_params [
    # TeamID: 1_610_612_744,
    Season: "2024-25"
  ]

  @invalid_params [
    TeamID: "foo",
    Season: 202_425
  ]

  @unknown_params [
    TeamID: 1_610_612_744,
    Season: "2024-25",
    RandomParam: "invalid"
  ]

  describe "get/1" do
    test "returns team game streak data with valid parameters" do
      assert {:ok, resp} = TeamGameStreakFinder.get(@valid_params)
      assert is_map(resp)
    end

    test "get!/1 returns team game streak data with valid parameters" do
      assert response = TeamGameStreakFinder.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               TeamGameStreakFinder.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = TeamGameStreakFinder.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = TeamGameStreakFinder.get(@unknown_params)
    end
  end
end
