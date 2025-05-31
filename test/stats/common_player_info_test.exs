defmodule NBA.Stats.CommonPlayerInfoTest do
  use ExUnit.Case
  alias NBA.Stats.CommonPlayerInfo

  describe "get/2 valid input" do
    test "fetches player data with custom parameters" do
      assert {:ok, result} = CommonPlayerInfo.get(PlayerID: 2544, LeagueID: "00")
      assert is_list(result)
      assert length(result) > 0
    end

    test "test bang function" do
      assert result = CommonPlayerInfo.get!(PlayerID: 2544, LeagueID: "00")
      assert is_list(result)
      assert length(result) > 0
    end
  end

  describe "get/2 invalid input" do
    test "returns error for invalid parameters type" do
      assert {:error, "Parameters and Options must be keyword lists or nil"} =
               CommonPlayerInfo.get("invalid")
    end

    test "returns error for invalid options type" do
      assert {:error, "Parameters and Options must be keyword lists or nil"} =
               CommonPlayerInfo.get([], "invalid")
    end
  end

  describe "get/2 with invalid parameters" do
    test "returns error for missing :PlayerID" do
      assert {:error, "Missing required parameter(s): :PlayerID"} =
               CommonPlayerInfo.get(LeagueID: "00")
    end

    test "returns error for nil :PlayerID" do
      assert {:error, "Missing required parameter(s): :PlayerID"} =
               CommonPlayerInfo.get(PlayerID: nil, LeagueID: "00")
    end

    test "returns error for invalid :PlayerID" do
      assert {:error, "Invalid type for PlayerID: got \"invalid\", accepts integer, string"} =
               CommonPlayerInfo.get(PlayerID: "invalid", LeagueID: "00")
    end

    test "returns error for invalid :LeagueID" do
      assert {:error, "Invalid type for LeagueID: got 123, accepts string"} =
               CommonPlayerInfo.get(PlayerID: 2544, LeagueID: 123)
    end
  end
end
