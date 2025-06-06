defmodule NBA.Stats.TeamGameLogTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamGameLog

  @valid_params [
    Season: "2024-25",
    TeamID: 1_610_612_744,
    SeasonType: "Regular Season",
    LeagueID: "00",
    DateTo: "01/31/2025",
    DateFrom: "01/01/2025"
  ]

  @invalid_params [
    Season: 202_425,
    TeamID: "foo",
    SeasonType: "Invalid",
    LeagueID: 0,
    DateTo: 20_250_131,
    DateFrom: 20_250_101
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    TeamID: 1_610_612_744
  ]

  describe "get/2" do
    test "returns team game log data with valid parameters" do
      assert {:ok, response} = TeamGameLog.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team game log data with valid parameters" do
      assert response = TeamGameLog.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season, :TeamID" <> _} =
               TeamGameLog.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamGameLog.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamGameLog.get(@unknown_params)
    end
  end
end
