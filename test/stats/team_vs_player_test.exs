defmodule NBA.Stats.TeamVsPlayerTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamVsPlayer

  @valid_params [
    # TeamID: 1_610_612_744,
    # VsPlayerID: 201_939,
    Season: "2024-25",
    MeasureType: "Base",
    PerMode: "PerGame",
    SeasonType: "Regular Season"
  ]

  @invalid_params [
    TeamID: "foo",
    VsPlayerID: "bar",
    MeasureType: "Invalid",
    PerMode: "Invalid",
    SeasonType: "Invalid"
  ]

  @unknown_params [
    TeamID: 1_610_612_744,
    VsPlayerID: 201_939,
    RandomParam: "invalid"
  ]

  describe "get/1" do
    test "returns team vs player data with valid parameters" do
      assert {:ok, resp} = TeamVsPlayer.get(@valid_params)
      assert is_map(resp)
      IO.inspect(resp, label: "TeamVsPlayer Response")
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = TeamVsPlayer.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = TeamVsPlayer.get(@unknown_params)
    end

    test "optional parameters can be nil or omitted" do
      params = [
        TeamID: 1_610_612_744,
        VsPlayerID: 201_939,
        Season: "2024-25",
        MeasureType: "Base",
        PerMode: "PerGame",
        SeasonType: "Regular Season",
        VsDivision: nil,
        VsConference: nil
      ]

      assert {:ok, resp} = TeamVsPlayer.get(params)
      assert is_map(resp)
    end
  end
end
