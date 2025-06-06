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

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :TeamID" <> _} =
               TeamGameLogs.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamGameLogs.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamGameLogs.get(@unknown_params)
    end
  end
end
