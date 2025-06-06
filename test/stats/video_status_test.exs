defmodule NBA.Stats.VideoStatusTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.VideoStatus

  @valid_params [
    GameDate: "2025-06-06",
    LeagueID: "00"
  ]

  @invalid_params [
    GameDate: 20_250_606,
    LeagueID: 0
  ]

  @unknown_params [
    RandomParam: "invalid",
    GameDate: "2025-06-06",
    LeagueID: "00"
  ]

  describe "get/2" do
    test "returns video status data with valid parameters" do
      assert {:ok, response} = VideoStatus.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns video status data with valid parameters" do
      assert response = VideoStatus.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GameDate" <> _} =
               VideoStatus.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = VideoStatus.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = VideoStatus.get(@unknown_params)
    end
  end
end
