defmodule NBA.Stats.FranchiseHistoryTest do
  use ExUnit.Case
  alias NBA.Stats.FranchiseHistory

  @invalid_params [Invalid: "invalid"]

  describe "get/2" do
    test "returns franchise history data for valid params" do
      assert {:ok, _data} = FranchiseHistory.get()
    end

    test "returns error for invalid params" do
      assert {:error, _reason} = FranchiseHistory.get(@invalid_params)
    end

    test "get!/2 returns data for valid parameters" do
      assert result = FranchiseHistory.get!()
      assert is_map(result)
    end
  end
end
