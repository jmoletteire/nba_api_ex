defmodule NBA.Stats.GameRotationTest do
  use ExUnit.Case
  alias NBA.Stats.GameRotation

  describe "get/2" do
    test "returns franchise player data for a valid team ID" do
      assert {:ok, _response} = GameRotation.get(GameID: "0042400305")
    end

    test "get!/2 returns franchise player data for a valid team ID" do
      assert response = GameRotation.get!(GameID: "0042400305")
      assert is_map(response)
      assert Map.has_key?(response, "AwayTeam")
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GameID"} = GameRotation.get()
    end

    test "returns error for invalid TeamID type" do
      assert {:error, _} = GameRotation.get(GameID: "invalid")
    end
  end
end
