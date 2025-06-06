defmodule NBA.Stats.VideoDetailsAssetTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.VideoDetailsAsset

  @valid_params [
    ContextMeasure: "FGM",
    LastNGames: 5,
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    Period: 1,
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_744
  ]

  @invalid_params [
    ContextMeasure: "INVALID",
    LastNGames: -1,
    Month: 13,
    OpponentTeamID: "foo",
    Period: 10,
    PlayerID: "bar",
    Season: 202_425,
    SeasonType: "Midseason",
    TeamID: "baz"
  ]

  @unknown_params [
    RandomParam: "invalid",
    ContextMeasure: "FGM"
  ]

  describe "get/2" do
    test "returns video details asset data with valid parameters" do
      assert {:ok, response} = VideoDetailsAsset.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns video details asset data with valid parameters" do
      assert response = VideoDetailsAsset.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error,
              "Missing required parameter(s): :ContextMeasure, :LastNGames, :Month, :OpponentTeamID, :Period, :PlayerID, :Season, :SeasonType, :TeamID" <>
                _} = VideoDetailsAsset.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = VideoDetailsAsset.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = VideoDetailsAsset.get(@unknown_params)
    end
  end
end
