defmodule NBA.Stats.TeamDashLineupsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamDashLineups

  @valid_params [
    GroupQuantity: 5,
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_744
  ]

  @invalid_params [
    GroupQuantity: "five",
    LastNGames: -1,
    MeasureType: "Invalid",
    Month: 13,
    OpponentTeamID: "foo",
    PaceAdjust: "X",
    PerMode: "PerYear",
    Period: 10,
    PlusMinus: "Q",
    Rank: "Z",
    Season: 202_425,
    SeasonType: "Midseason",
    TeamID: "bar"
  ]

  @unknown_params [
    RandomParam: "invalid",
    GroupQuantity: 5,
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_744
  ]

  describe "get/2" do
    test "returns team dash lineups data with valid parameters" do
      assert {:ok, response} = TeamDashLineups.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team dash lineups data with valid parameters" do
      assert response = TeamDashLineups.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error,
              "Missing required parameter(s): :GroupQuantity, :Season, :TeamID" <>
                _} = TeamDashLineups.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamDashLineups.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamDashLineups.get(@unknown_params)
    end

    test "nullable/optional parameters are handled correctly" do
      params =
        Keyword.merge(@valid_params,
          VsDivision: nil,
          VsConference: nil,
          ShotClockRange: nil,
          SeasonSegment: nil,
          PORound: nil,
          Outcome: nil,
          Location: nil,
          LeagueID: nil,
          GameSegment: nil,
          GameID: nil,
          DateTo: nil,
          DateFrom: nil
        )

      assert {:ok, response} = TeamDashLineups.get(params)
      assert is_map(response)
    end
  end
end
