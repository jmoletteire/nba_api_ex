defmodule NBA.Stats.TeamGameLogsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamGameLogs

  @valid_params [
    # Season: "2024-25",
    TeamID: 1_610_612_744
  ]

  @invalid_params [
    Season: 202_425,
    TeamID: "foo",
    LastNGames: "ten",
    Month: "Jan",
    OppTeamID: "bar"
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25",
    TeamID: 1_610_612_744
  ]

  describe "get/2" do
    test "returns team game logs data with valid parameters" do
      assert {:ok, response} = TeamGameLogs.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team game logs data with valid parameters" do
      assert response = TeamGameLogs.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamGameLogs.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamGameLogs.get(@unknown_params)
    end

    test "nullable/optional parameters are handled correctly" do
      params =
        Keyword.merge(@valid_params,
          VsDivision: nil,
          VsConference: nil,
          ShotClockRange: nil,
          SeasonType: nil,
          SeasonSegment: nil,
          PlayerID: nil,
          Period: nil,
          PerMode: nil,
          PORound: nil,
          Outcome: nil,
          OppTeamID: nil,
          Month: nil,
          MeasureType: nil,
          Location: nil,
          LeagueID: nil,
          LastNGames: nil,
          GameSegment: nil,
          DateTo: nil,
          DateFrom: nil
        )

      assert {:ok, response} = TeamGameLogs.get(params)
      assert is_map(response)
    end
  end
end
