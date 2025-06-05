defmodule NBA.Stats.PlayerFantasyProfileBarGraphTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerFantasyProfileBarGraph

  @valid_params [
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    LeagueID: "00"
  ]

  @invalid_params [
    PlayerID: :not_an_id,
    Season: 202_425,
    SeasonType: "Season",
    LeagueID: 0
  ]

  @unknown_params [
    RandomParam: "invalid",
    PlayerID: 201_939,
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player fantasy profile bar graph data with valid parameters" do
      assert {:ok, response} = PlayerFantasyProfileBarGraph.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player fantasy profile bar graph data with valid parameters" do
      assert response = PlayerFantasyProfileBarGraph.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID, :Season" <> _} =
               PlayerFantasyProfileBarGraph.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerFantasyProfileBarGraph.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerFantasyProfileBarGraph.get(@unknown_params)
    end
  end
end
