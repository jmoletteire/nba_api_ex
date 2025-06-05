defmodule NBA.Stats.PlayerGameLogsTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerGameLogs

  @valid_params [
    PlayerID: 201_939,
    SeasonYear: "2024-25",
    SeasonType: "Regular Season",
    LeagueID: "00",
    DateTo: "01/31/2025",
    DateFrom: "01/01/2025",
    TeamID: 1_610_612_737,
    OpposingTeamID: 1_610_612_738,
    PerMode: "Totals",
    MeasureType: "Base",
    LastNGames: 10,
    Period: 1,
    PORound: 1,
    Month: 1,
    Outcome: "W",
    Location: "Home",
    GameSegment: "First Half",
    SeasonSegment: "Pre All-Star",
    # ShotClockRange: "24-22",
    VsDivision: "Atlantic",
    VsConference: "East"
  ]

  @invalid_params [
    PlayerID: :not_an_id,
    Season: 202_425,
    SeasonType: 123,
    LeagueID: 0,
    DateTo: 20_240_131,
    DateFrom: 20_240_101,
    TeamID: :not_an_id,
    OpposingTeamID: :not_an_id,
    PerMode: 123,
    MeasureType: 123,
    LastNGames: "ten",
    Period: "First",
    PORound: "First",
    Month: "January",
    Outcome: 1,
    Location: 1,
    GameSegment: 1,
    SeasonSegment: 1,
    ShotClockRange: 1,
    VsDivision: 1,
    VsConference: 1
  ]

  @unknown_params [
    RandomParam: "invalid",
    PlayerID: 201_939,
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player game logs data with valid parameters" do
      assert {:ok, response} = PlayerGameLogs.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player game logs data with valid parameters" do
      assert response = PlayerGameLogs.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerGameLogs.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerGameLogs.get(@unknown_params)
    end
  end
end
