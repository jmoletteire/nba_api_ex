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

    test "returns error for invalid parameters" do
      assert {:error, _} = TeamGameStreakFinder.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = TeamGameStreakFinder.get(@unknown_params)
    end

    test "optional parameters can be nil or omitted" do
      params = [TeamID: 1_610_612_744, Season: "2024-25", LeagueID: nil, SeasonType: nil]
      assert {:ok, resp} = TeamGameStreakFinder.get(params)
      assert is_map(resp)
    end
  end
end
