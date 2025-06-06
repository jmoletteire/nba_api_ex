defmodule NBA.Stats.ScheduleLeagueV2IntTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.ScheduleLeagueV2Int

  @valid_params [
    LeagueID: "00",
    Season: "2024-25"
  ]

  @invalid_params [
    LeagueID: 0,
    Season: 202_425
  ]

  @unknown_params [
    LeagueID: "00",
    Season: "2024-25",
    UnknownParam: "foo"
  ]

  describe "get/2" do
    test "returns data with valid parameters" do
      assert {:ok, data} = ScheduleLeagueV2Int.get(@valid_params)
      assert is_map(data)
    end

    test "get!/2 returns data with valid parameters" do
      assert response = ScheduleLeagueV2Int.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      params = Keyword.delete(@valid_params, :Season)
      assert {:error, _} = ScheduleLeagueV2Int.get(params)
    end

    test "returns error for invalid parameter types" do
      assert {:error, _} = ScheduleLeagueV2Int.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = ScheduleLeagueV2Int.get(@unknown_params)
    end
  end
end
