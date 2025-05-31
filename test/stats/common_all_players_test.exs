defmodule NBA.Stats.CommonAllPlayersTest do
  use ExUnit.Case
  alias NBA.Stats.CommonAllPlayers

  describe "get/2 valid input" do
    test "fetches all players data with default parameters" do
      assert {:ok, result} = CommonAllPlayers.get()
      assert is_list(result)
      assert length(result) > 0
    end

    test "fetches all players data with custom parameters" do
      params = [LeagueID: "00", IsOnlyCurrentSeason: "1", Season: "2024-25"]

      assert {:ok, result} = CommonAllPlayers.get(params)
      assert is_list(result)
      assert length(result) > 0
    end

    test "test bang function" do
      params = [LeagueID: "00", IsOnlyCurrentSeason: "1", Season: "2024-25"]

      assert result = CommonAllPlayers.get!(params)
      assert is_list(result)
      assert length(result) > 0
    end
  end

  describe "get/2 invalid args" do
    test "returns error for invalid parameters type" do
      assert {:error, "Parameters and Options must be keyword lists or nil"} =
               CommonAllPlayers.get("invalid")
    end

    test "returns error for invalid options type" do
      assert {:error, "Parameters and Options must be keyword lists or nil"} =
               CommonAllPlayers.get([], "invalid")
    end
  end

  describe "get/2 invalid parameter types" do
    test "returns error for invalid :LeagueID type" do
      params = [LeagueID: 123, IsOnlyCurrentSeason: "1", Season: "2024-25"]

      assert {:error, "Invalid type for LeagueID: got 123, accepts string"} =
               CommonAllPlayers.get(params)
    end

    test "returns error for invalid :IsOnlyCurrentSeason type" do
      params = [LeagueID: "00", IsOnlyCurrentSeason: 1, Season: "2024-25"]

      assert {:error, "Invalid type for IsOnlyCurrentSeason: got 1, accepts string"} =
               CommonAllPlayers.get(params)
    end

    test "returns error for invalid :Season type" do
      params = [LeagueID: "00", IsOnlyCurrentSeason: "1", Season: :invalid]

      assert {:error, "Invalid type for Season: got :invalid, accepts string"} =
               CommonAllPlayers.get(params)
    end
  end

  describe "get/2 invalid parameter values" do
    test "returns empty for nonexistent :LeagueID" do
      params = [LeagueID: "55"]

      assert {:ok, []} =
               CommonAllPlayers.get(params)
    end

    test "returns error for invalid :IsOnlyCurrentSeason value" do
      params = [IsOnlyCurrentSeason: "-1"]

      assert {:error, "Bad request (400). Check your query parameters."} =
               CommonAllPlayers.get(params)
    end

    test "returns empty for nonexistent :Season" do
      params = [LeagueID: "00", IsOnlyCurrentSeason: "1", Season: "1900-01"]

      assert {:ok, []} =
               CommonAllPlayers.get(params)
    end
  end
end
