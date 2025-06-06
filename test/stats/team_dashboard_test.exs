defmodule NBA.Stats.TeamDashboardTest do
  use ExUnit.Case
  alias NBA.Stats.TeamDashboard

  @valid_params [
    LastNGames: 10,
    MeasureType: "Base",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 1,
    TeamID: 201_939,
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
    TeamID: :not_an_id,
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
    TeamID: 201_939,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season"
  ]

  describe "get/2" do
    test "returns team dashboard by clutch data with valid parameters" do
      assert {:ok, response} = TeamDashboard.get(:clutch, @valid_params)
      assert is_map(response)
    end

    test "clutch" do
      assert {:ok, response} = TeamDashboard.get(:clutch, @valid_params)
      assert is_map(response)
    end

    test "game splits" do
      assert {:ok, response} = TeamDashboard.get(:game_splits, @valid_params)
      assert is_map(response)
    end

    test "general splits" do
      assert {:ok, response} = TeamDashboard.get(:general_splits, @valid_params)
      assert is_map(response)
    end

    test "opponent" do
      assert {:ok, response} = TeamDashboard.get(:opponent, @valid_params)
      assert is_map(response)
    end

    test "last n games" do
      assert {:ok, response} = TeamDashboard.get(:last_n_games, @valid_params)
      assert is_map(response)
    end

    test "shooting splits" do
      assert {:ok, response} = TeamDashboard.get(:shooting_splits, @valid_params)
      assert is_map(response)
    end

    test "team performance" do
      assert {:ok, response} = TeamDashboard.get(:team_performance, @valid_params)
      assert is_map(response)
    end

    test "YoY" do
      assert {:ok, response} = TeamDashboard.get(:year_over_year, @valid_params)
      assert is_map(response)
    end

    test "Players" do
      assert {:ok, response} = TeamDashboard.get(:players, @valid_params)
      assert is_map(response)
    end

    test "On/Off Details" do
      assert {:ok, response} = TeamDashboard.get(:on_off_detail, @valid_params)
      assert is_map(response)
    end

    test "On/Off Summary" do
      assert {:ok, response} = TeamDashboard.get(:on_off_summary, @valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team dashboard by clutch data with valid parameters" do
      assert response = TeamDashboard.get!(:clutch, @valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :TeamID, :Season" <> _} =
               TeamDashboard.get(:clutch, [])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamDashboard.get(:clutch, @invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamDashboard.get(:clutch, @unknown_params)
    end
  end
end
