defmodule NBA.Stats.PlayerGameLogTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerGameLog

  @valid_params [
    PlayerID: 2544,
    Season: "2024-25",
    SeasonType: "Regular Season",
    LeagueID: "00",
    DateTo: "01/31/2025",
    DateFrom: "01/01/2025"
  ]

  @invalid_params [
    PlayerID: :not_an_id,
    Season: 202_425,
    SeasonType: "Season",
    LeagueID: 0,
    DateTo: 20_240_131,
    DateFrom: 20_240_101
  ]

  @unknown_params [
    RandomParam: "invalid",
    PlayerID: 201_939,
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player game log data with valid parameters" do
      assert {:ok, response} = PlayerGameLog.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player game log data with valid parameters" do
      assert response = PlayerGameLog.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID, :Season" <> _} =
               PlayerGameLog.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerGameLog.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerGameLog.get(@unknown_params)
    end
  end
end
