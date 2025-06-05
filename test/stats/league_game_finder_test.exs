defmodule NBA.Stats.LeagueGameFinderTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueGameFinder

  @valid_params [
    LeagueID: "00",
    PlayerOrTeam: "P",
    SeasonType: "Regular Season",
    LtPTS: 20
  ]

  @invalid_params [
    # should be string
    LeagueID: 0,
    # should be string
    PlayerOrTeam: 123,
    # should be integer
    PORound: "first"
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00"
  ]

  describe "get/2" do
    test "returns league game finder data with valid parameters" do
      assert {:ok, response} = LeagueGameFinder.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league game finder data with valid parameters" do
      assert response = LeagueGameFinder.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueGameFinder.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueGameFinder.get(@unknown_params)
    end
  end
end
