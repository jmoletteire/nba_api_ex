defmodule NBA.Stats.ISTStandingsTest do
  use ExUnit.Case
  alias NBA.Stats.ISTStandings

  @valid_params [
    LeagueID: "00",
    Season: "2023-24",
    Section: "group"
  ]
  @invalid_params [
    LeagueID: "invalid",
    Season: "2023-24",
    Section: "group"
  ]
  @unknown_params [
    Invalid: "00",
    Season: "2023-24"
  ]

  describe "get/2" do
    test "returns IST standings data with default parameters" do
      assert {:ok, _response} = ISTStandings.get(@valid_params)
    end

    test "get!/2 returns IST standings data with default parameters" do
      assert response = ISTStandings.get!(@valid_params)
      assert is_map(response)
      assert Map.has_key?(response, "teams")
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :Season"} = ISTStandings.get()
    end

    test "returns error for invalid parameters" do
      assert {:error, _} = ISTStandings.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = ISTStandings.get(@unknown_params)
    end
  end
end
