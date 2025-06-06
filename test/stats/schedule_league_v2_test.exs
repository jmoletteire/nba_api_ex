defmodule NBA.Stats.ScheduleLeagueV2Test do
  use ExUnit.Case, async: true
  alias NBA.Stats.ScheduleLeagueV2

  @valid_params [
    LeagueID: "00",
    Season: "2024-25"
  ]

  describe ".get/2" do
    test "returns data with valid parameters" do
      assert {:ok, data} = ScheduleLeagueV2.get(@valid_params)
      assert is_map(data)
    end

    test "fails with missing required parameters" do
      params = Keyword.delete(@valid_params, :Season)
      assert {:error, _} = ScheduleLeagueV2.get(params)
    end

    test "fails with invalid parameter types" do
      # LeagueID as integer
      params = Keyword.put(@valid_params, :LeagueID, 0)
      assert {:error, _} = ScheduleLeagueV2.get(params)
      # Season as integer
      params = Keyword.put(@valid_params, :Season, 202_425)
      assert {:error, _} = ScheduleLeagueV2.get(params)
    end

    test "handles unknown parameters gracefully" do
      params = Keyword.put(@valid_params, :UnknownParam, "foo")
      assert {:error, _} = ScheduleLeagueV2.get(params)
    end

    test "LeagueID is optional and defaults to '00' if not provided" do
      params = Keyword.delete(@valid_params, :LeagueID)
      assert {:ok, data} = ScheduleLeagueV2.get(params)
      assert is_map(data)
    end
  end
end
