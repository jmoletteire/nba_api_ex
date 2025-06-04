defmodule NBA.Stats.FranchisePlayersTest do
  use ExUnit.Case
  alias NBA.Stats.FranchisePlayers

  describe "get/2" do
    test "returns franchise player data for a valid team ID" do
      assert {:ok, _response} = FranchisePlayers.get(TeamID: 1_610_612_747)
    end

    test "get!/2 returns franchise player data for a valid team ID" do
      assert response = FranchisePlayers.get!(TeamID: 1_610_612_747)
      assert is_map(response)
      assert Map.has_key?(response, "FranchisePlayers")
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :TeamID"} = FranchisePlayers.get([])
    end

    test "returns error for invalid TeamID type" do
      assert {:error, _} = FranchisePlayers.get(TeamID: "invalid")
    end
  end
end
