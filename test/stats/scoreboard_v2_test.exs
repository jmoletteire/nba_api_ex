defmodule NBA.Stats.ScoreboardV2Test do
  use ExUnit.Case, async: true
  alias NBA.Stats.ScoreboardV2

  @valid_params [
    DayOffset: 0,
    GameDate: "2025-03-01",
    LeagueID: "00"
  ]

  @invalid_params [
    # expecting integer
    DayOffset: "zero",
    # expecting date string
    GameDate: 20_250_301,
    # expecting string
    LeagueID: 0
  ]

  @unknown_params [
    RandomParam: "invalid",
    GameDate: "2025-03-01"
  ]

  describe "get/2" do
    test "returns scoreboard data with valid parameters" do
      assert {:ok, response} = ScoreboardV2.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns scoreboard data with valid parameters" do
      assert response = ScoreboardV2.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GameDate" <> _} =
               ScoreboardV2.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = ScoreboardV2.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = ScoreboardV2.get(@unknown_params)
    end
  end
end
