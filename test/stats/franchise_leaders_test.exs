defmodule NBA.Stats.FranchiseLeadersTest do
  use ExUnit.Case
  alias NBA.Stats.FranchiseLeaders

  @valid_params [TeamID: 1_610_612_739, LeagueID: "00"]
  @invalid_params [Invalid: "invalid"]

  describe "get/2" do
    test "returns franchise history data for valid params" do
      assert {:ok, data} = FranchiseLeaders.get(@valid_params)
      IO.inspect(data, label: "Franchise Leaders Data")
    end

    test "returns error for invalid params" do
      assert {:error, _reason} = FranchiseLeaders.get(@invalid_params)
    end

    test "get!/2 returns data for valid parameters" do
      assert result = FranchiseLeaders.get!(@valid_params)
      assert is_map(result)
    end
  end
end
