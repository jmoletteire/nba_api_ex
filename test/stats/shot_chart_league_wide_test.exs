defmodule NBA.Stats.ShotChartLeagueWideTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.ShotChartLeagueWide

  @valid_params [
    LeagueID: "00",
    Season: "2024-25"
  ]

  @invalid_params [
    # expecting string
    LeagueID: 0,
    # expecting string
    Season: 202_425
  ]

  @unknown_params [
    RandomParam: "invalid",
    Season: "2024-25"
  ]

  describe "get/2" do
    test "returns league-wide shot chart data with valid parameters" do
      assert {:ok, response} = ShotChartLeagueWide.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns league-wide shot chart data with valid parameters" do
      assert response = ShotChartLeagueWide.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season" <> _} =
               ShotChartLeagueWide.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = ShotChartLeagueWide.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = ShotChartLeagueWide.get(@unknown_params)
    end

    test "LeagueID is optional and defaults to '00' if not provided" do
      params = Keyword.delete(@valid_params, :LeagueID)
      assert {:ok, response} = ShotChartLeagueWide.get(params)
      assert is_map(response)
    end
  end
end
