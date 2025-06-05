defmodule NBA.Stats.PlayerDashboardTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerDashboard

  @valid_params [
    LastNGames: 10,
    MeasureType: "Base",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 1,
    PlayerID: 201_939,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    LastNGames: "ten",
    MeasureType: "Unknown",
    Month: "January",
    OpponentTeamID: :not_an_id,
    PaceAdjust: "Maybe",
    PerMode: "PerMonth",
    Period: "First",
    PlayerID: :not_an_id,
    PlusMinus: "Maybe",
    Rank: "Maybe",
    Season: 202_425,
    SeasonType: "Season"
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
    PlayerID: 201_939,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns player dashboard by clutch data with valid parameters" do
      assert {:ok, response} = PlayerDashboard.get(:clutch, @valid_params)
      assert is_map(response)
    end

    test "clutch" do
      assert {:ok, response} = PlayerDashboard.get(:clutch, @valid_params)
      assert is_map(response)
    end

    test "game splits" do
      assert {:ok, response} = PlayerDashboard.get(:game_splits, @valid_params)
      assert is_map(response)
    end

    test "general splits" do
      assert {:ok, response} = PlayerDashboard.get(:general_splits, @valid_params)
      assert is_map(response)
    end

    test "last n games" do
      assert {:ok, response} = PlayerDashboard.get(:last_n_games, @valid_params)
      assert is_map(response)
    end

    test "shooting splits" do
      assert {:ok, response} = PlayerDashboard.get(:shooting_splits, @valid_params)
      assert is_map(response)
    end

    test "team performance" do
      assert {:ok, response} = PlayerDashboard.get(:team_performance, @valid_params)
      assert is_map(response)
    end

    test "YoY" do
      assert {:ok, response} = PlayerDashboard.get(:year_over_year, @valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player dashboard by clutch data with valid parameters" do
      assert response = PlayerDashboard.get!(:clutch, @valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID, :Season" <> _} =
               PlayerDashboard.get(:clutch, [])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerDashboard.get(:clutch, @invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerDashboard.get(:clutch, @unknown_params)
    end
  end
end
