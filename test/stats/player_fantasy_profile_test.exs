defmodule NBA.Stats.PlayerFantasyProfileTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerFantasyProfile

  @valid_params [
    MeasureType: "Base",
    PaceAdjust: "N",
    PerMode: "Totals",
    PlayerID: 201_939,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    LeagueID: "00"
  ]

  @invalid_params [
    MeasureType: "Advanced",
    PaceAdjust: "Y",
    PerMode: "PerMonth",
    PlayerID: :not_an_id,
    PlusMinus: "Y",
    Rank: "Y",
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
    test "returns player fantasy profile data with valid parameters" do
      assert {:ok, response} = PlayerFantasyProfile.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player fantasy profile data with valid parameters" do
      assert response = PlayerFantasyProfile.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID, :Season" <> _} =
               PlayerFantasyProfile.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerFantasyProfile.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerFantasyProfile.get(@unknown_params)
    end
  end
end
