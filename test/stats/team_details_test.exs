defmodule NBA.Stats.TeamDetailsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.TeamDetails

  @valid_params [
    TeamID: 1_610_612_744
  ]

  @invalid_params [
    TeamID: "foo"
  ]

  @unknown_params [
    RandomParam: "invalid",
    TeamID: 1_610_612_744
  ]

  describe "get/2" do
    test "returns team details data with valid parameters" do
      assert {:ok, response} = TeamDetails.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns team details data with valid parameters" do
      assert response = TeamDetails.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :TeamID" <> _} = TeamDetails.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = TeamDetails.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = TeamDetails.get(@unknown_params)
    end
  end
end
