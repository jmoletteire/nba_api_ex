defmodule NBA.Stats.VideoEventsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.VideoEvents

  @valid_params [
    GameEventID: 1,
    GameID: "0022100001"
  ]

  @invalid_params [
    GameEventID: "foo",
    GameID: 123
  ]

  @unknown_params [
    RandomParam: "invalid",
    GameEventID: 1,
    GameID: "0022100001"
  ]

  describe "get/2" do
    test "returns video events data with valid parameters" do
      assert {:ok, response} = VideoEvents.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns video events data with valid parameters" do
      assert response = VideoEvents.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :GameID" <> _} =
               VideoEvents.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = VideoEvents.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = VideoEvents.get(@unknown_params)
    end
  end
end
