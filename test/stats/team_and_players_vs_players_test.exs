defmodule NBA.Stats.TeamAndPlayersVsPlayersTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamAndPlayersVsPlayers

  @valid_params [
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerID1: 201_939,
    PlayerID2: 202_691,
    PlayerID3: 203_507,
    PlayerID4: 1_629_029,
    PlayerID5: 1_629_630,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_744,
    VsPlayerID1: 1_627_759,
    VsPlayerID2: 1_628_369,
    VsPlayerID3: 1_629_027,
    VsPlayerID4: 1_629_631,
    VsPlayerID5: 1_630_162,
    VsTeamID: 1_610_612_738
  ]

  @invalid_params [
    LastNGames: -1,
    MeasureType: "Invalid",
    Month: 13,
    OpponentTeamID: "foo",
    PaceAdjust: "X",
    PerMode: "PerYear",
    Period: 10,
    PlayerID1: "bar",
    PlayerID2: "baz",
    PlayerID3: "qux",
    PlayerID4: "quux",
    PlayerID5: "corge",
    PlusMinus: "Z",
    Rank: "Q",
    Season: 202_425,
    SeasonType: "Midseason",
    TeamID: "grault",
    VsPlayerID1: "garply",
    VsPlayerID2: "waldo",
    VsPlayerID3: "fred",
    VsPlayerID4: "plugh",
    VsPlayerID5: "xyzzy",
    VsTeamID: "thud"
  ]

  @unknown_params [
    RandomParam: "invalid",
    LastNGames: 0,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerID1: 201_939,
    PlayerID2: 202_691,
    PlayerID3: 203_507,
    PlayerID4: 1_629_029,
    PlayerID5: 1_629_630,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_744,
    VsPlayerID1: 1_627_759,
    VsPlayerID2: 1_628_369,
    VsPlayerID3: 1_629_027,
    VsPlayerID4: 1_629_631,
    VsPlayerID5: 1_630_162,
    VsTeamID: 1_610_612_738
  ]

  describe "get/2" do
    test "returns team and players vs players data with valid parameters" do
      assert {:ok, response} = TeamAndPlayersVsPlayers.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team and players vs players data with valid parameters" do
      assert response = TeamAndPlayersVsPlayers.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error,
              "Missing required parameter(s): :PlayerID1, :PlayerID2, :PlayerID3, :PlayerID4, :PlayerID5, :Season, :TeamID, :VsPlayerID1, :VsPlayerID2, :VsPlayerID3, :VsPlayerID4, :VsPlayerID5, :VsTeamID" <>
                _} = TeamAndPlayersVsPlayers.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamAndPlayersVsPlayers.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamAndPlayersVsPlayers.get(@unknown_params)
    end
  end
end
