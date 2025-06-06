defmodule NBA.Stats.TeamDashPtTest do
  use ExUnit.Case
  alias NBA.Stats.TeamDashPt

  @valid_params [
    LastNGames: 10,
    LeagueID: "00",
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    PerMode: "Totals",
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
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_737
  ]

  describe "get/2" do
    test "returns team dash pt pass data with valid parameters" do
      assert {:ok, response} = TeamDashPt.get(:passing, @valid_params)
      assert is_map(response)
    end

    test "passing" do
      assert {:ok, response} = TeamDashPt.get(:passing, @valid_params)
      assert is_map(response)
    end

    test "rebounding" do
      assert {:ok, response} = TeamDashPt.get(:rebounding, @valid_params)
      assert is_map(response)
    end

    test "shooting" do
      assert {:ok, response} = TeamDashPt.get(:shooting, @valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team dash pt pass data with valid parameters" do
      assert response = TeamDashPt.get!(:passing, @valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :TeamID, :Season" <> _} =
               TeamDashPt.get(:passing, [])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamDashPt.get(:passing, @invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamDashPt.get(:passing, @unknown_params)
    end
  end
end
