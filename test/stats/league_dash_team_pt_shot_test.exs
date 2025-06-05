defmodule NBA.Stats.LeagueDashTeamPtShotTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.LeagueDashTeamPtShot

  @invalid_params [
    LeagueID: "invalid",
    Season: "2023-24"
  ]
  @unknown_params [
    Invalid: "00",
    Season: "2023-24"
  ]

  describe "get/2" do
    test "returns league lineup data with default parameters" do
      assert {:ok, _response} = LeagueDashTeamPtShot.get(:team, Season: "2024-25")
    end

    test "get!/2 returns league lineup data with default parameters" do
      assert response = LeagueDashTeamPtShot.get!(:team, Season: "2024-25")
      assert is_map(response)
      IO.inspect(response, label: "LeagueDashOppPtShot.get!/2 response")
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season"} =
               LeagueDashTeamPtShot.get(:team, [])
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = LeagueDashTeamPtShot.get(:team, @invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = LeagueDashTeamPtShot.get(:team, @unknown_params)
    end
  end
end
