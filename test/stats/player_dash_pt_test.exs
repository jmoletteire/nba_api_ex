defmodule NBA.Stats.PlayerDashPtTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerDashPt

  @valid_params [
    LastNGames: 10,
    LeagueID: "00",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PerMode: "Totals",
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_737
  ]

  @invalid_params [
    LastNGames: "ten",
    LeagueID: 0,
    Month: "January",
    OpponentTeamID: :not_an_id,
    PerMode: "PerMonth",
    PlayerID: :not_an_id,
    Season: 202_425,
    SeasonType: "Season",
    TeamID: :not_an_id
  ]

  @unknown_params [
    RandomParam: "invalid",
    LastNGames: 10,
    LeagueID: "00",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PerMode: "Totals",
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_737
  ]

  describe "get/2" do
    test "returns player dash pt pass data with valid parameters" do
      assert {:ok, response} = PlayerDashPt.get(:passing, @valid_params)
      assert is_map(response)
    end

    test "passing" do
      assert {:ok, response} = PlayerDashPt.get(:passing, @valid_params)
      assert is_map(response)
    end

    test "rebounding" do
      assert {:ok, response} = PlayerDashPt.get(:rebounding, @valid_params)
      assert is_map(response)
    end

    test "shooting" do
      assert {:ok, response} = PlayerDashPt.get(:shooting, @valid_params)
      assert is_map(response)
    end

    test "defense" do
      assert {:ok, response} = PlayerDashPt.get(:defense, @valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player dash pt pass data with valid parameters" do
      assert response = PlayerDashPt.get!(:passing, @valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID, :Season" <> _} =
               PlayerDashPt.get(:passing, [])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerDashPt.get(:passing, @invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerDashPt.get(:passing, @unknown_params)
    end
  end
end
