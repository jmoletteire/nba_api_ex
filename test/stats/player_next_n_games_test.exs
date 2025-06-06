defmodule NBA.Stats.PlayerNextNGamesTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.PlayerNextNGames

  @valid_params [
    NumberOfGames: 5,
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    LeagueID: "00"
  ]

  @invalid_params [
    NumberOfGames: "five",
    PlayerID: "foo",
    Season: "202425",
    SeasonType: "Midseason",
    LeagueID: 0
  ]

  @unknown_params [
    NumberOfGames: 5,
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    LeagueID: "00",
    UnknownParam: "foo"
  ]

  describe "get/2" do
    test "returns data with valid parameters" do
      assert {:ok, data} = PlayerNextNGames.get(@valid_params)
      assert is_map(data)
    end

    test "get!/2 returns data with valid parameters" do
      assert response = PlayerNextNGames.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      params = Keyword.delete(@valid_params, :PlayerID)
      assert {:error, _} = PlayerNextNGames.get(params)
      params = Keyword.delete(@valid_params, :Season)
      assert {:error, _} = PlayerNextNGames.get(params)
    end

    test "returns error for invalid parameter types or values" do
      assert {:error, _} = PlayerNextNGames.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = PlayerNextNGames.get(@unknown_params)
    end
  end
end
