defmodule NBA.Stats.PlayoffPictureTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.PlayoffPicture

  @valid_params [
    LeagueID: "00",
    SeasonID: "22022"
  ]

  describe "get/2" do
    test "returns data with valid parameters" do
      assert {:ok, data} = PlayoffPicture.get(@valid_params)
      assert is_map(data)
    end

    test "fails with missing required parameters" do
      params = Keyword.delete(@valid_params, :SeasonID)
      assert {:error, _} = PlayoffPicture.get(params)
    end

    test "fails with invalid parameter types or values" do
      # LeagueID as integer
      params = Keyword.put(@valid_params, :LeagueID, 0)
      assert {:error, _} = PlayoffPicture.get(params)
      # LeagueID with invalid pattern
      params = Keyword.put(@valid_params, :LeagueID, "NBA")
      assert {:error, _} = PlayoffPicture.get(params)
    end

    test "handles unknown parameters gracefully" do
      params = Keyword.put(@valid_params, :UnknownParam, "foo")
      assert {:error, _} = PlayoffPicture.get(params)
    end
  end
end
