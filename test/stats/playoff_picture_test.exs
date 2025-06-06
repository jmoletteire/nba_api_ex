defmodule NBA.Stats.PlayoffPictureTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.PlayoffPicture

  @valid_params [
    LeagueID: "00",
    SeasonID: "22022"
  ]

  @invalid_params [
    LeagueID: 0,
    SeasonID: 22022
  ]

  @unknown_params [
    LeagueID: "00",
    SeasonID: "22022",
    UnknownParam: "foo"
  ]

  describe "get/2" do
    test "returns data with valid parameters" do
      assert {:ok, data} = PlayoffPicture.get(@valid_params)
      assert is_map(data)
    end

    test "get!/2 returns data with valid parameters" do
      assert response = PlayoffPicture.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      params = Keyword.delete(@valid_params, :SeasonID)
      assert {:error, _} = PlayoffPicture.get(params)
    end

    test "returns error for invalid parameter types or values" do
      assert {:error, _} = PlayoffPicture.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _} = PlayoffPicture.get(@unknown_params)
    end
  end
end
