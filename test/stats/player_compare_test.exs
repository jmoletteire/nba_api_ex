defmodule NBA.Stats.PlayerCompareTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerCompare

  @valid_params [
    LastNGames: 10,
    MeasureType: "Base",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 1,
    PlayerIDList: "201939,202691",
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    VsPlayerIDList: "201939,202691"
  ]

  @invalid_params [
    LastNGames: "ten",
    MeasureType: "Unknown",
    Month: "January",
    OpponentTeamID: :not_an_id,
    PaceAdjust: "Maybe",
    PerMode: "PerMonth",
    Period: "First",
    PlayerIDList: 123,
    PlusMinus: "Maybe",
    Rank: "Maybe",
    Season: 202_425,
    SeasonType: "Season",
    VsPlayerIDList: 123
  ]

  @unknown_params [
    RandomParam: "invalid",
    LastNGames: 10,
    MeasureType: "Base",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 1,
    PlayerIDList: "201939,202691",
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    VsPlayerIDList: "201939,202691"
  ]

  describe "get/2" do
    test "returns player compare data with valid parameters" do
      assert {:ok, response} = PlayerCompare.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player compare data with valid parameters" do
      assert response = PlayerCompare.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error,
              "Missing required parameter(s): :PlayerIDList, :Season, :VsPlayerIDList" <> _} =
               PlayerCompare.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerCompare.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerCompare.get(@unknown_params)
    end
  end
end
