defmodule NBA.Stats.PlayerIndexTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerIndex

  @valid_params [
    LeagueID: "00",
    Season: "2024-25",
    Active: 0,
    AllStar: 0,
    College: "Duke",
    Country: "USA",
    DraftPick: "1",
    DraftRound: "1",
    DraftYear: "2022",
    Height: "6-10",
    Historical: 1,
    TeamID: 1_610_612_753,
    Weight: 250
  ]

  @invalid_params [
    LeagueID: 0,
    Season: 202_425,
    Active: 1,
    AllStar: 1,
    College: 123,
    Country: 123,
    DraftPick: 1,
    DraftRound: 1,
    DraftYear: 2003,
    Height: 68,
    Historical: 1,
    TeamID: :not_an_id,
    Weight: 250
  ]

  @unknown_params [
    RandomParam: "invalid",
    LeagueID: "00",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns player index data with valid parameters" do
      assert {:ok, response} = PlayerIndex.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns player index data with valid parameters" do
      assert response = PlayerIndex.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               PlayerIndex.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = PlayerIndex.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = PlayerIndex.get(@unknown_params)
    end
  end
end
