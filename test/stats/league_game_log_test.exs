defmodule NBA.Stats.LeagueGameLogTest do
  use ExUnit.Case
  alias NBA.Stats.LeagueGameLog

  @valid_params [
    Counter: 1000,
    Direction: "DESC",
    LeagueID: "00",
    PlayerOrTeam: "P",
    Season: "2024-25",
    SeasonType: "Regular Season",
    Sorter: "DATE"
  ]

  @invalid_params [
    # should be integer
    Counter: "one thousand",
    # should be "ASC" or "DESC"
    Direction: "DOWN",
    # should be string
    LeagueID: 0,
    # should be "P" or "T"
    PlayerOrTeam: "X",
    # should be string
    Season: 202_425,
    # not in valueset
    SeasonType: "Season",
    # not in valueset
    Sorter: "INVALID"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    PlayerOrTeam: "P"
  ]

  describe "get/2" do
    test "returns league game log data with valid parameters" do
      assert {:ok, response} = LeagueGameLog.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league game log data with valid parameters" do
      assert response = LeagueGameLog.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               LeagueGameLog.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = LeagueGameLog.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = LeagueGameLog.get(@unknown_params)
    end
  end
end
