defmodule NBA.Stats.PlayerNextNGamesTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.PlayerNextNGames

  describe ".get/2" do
    @valid_params [
      NumberOfGames: 5,
      PlayerID: 201_939,
      Season: "2024-25",
      SeasonType: "Regular Season",
      LeagueID: "00"
    ]

    test "returns data with valid parameters" do
      assert {:ok, data} = PlayerNextNGames.get(@valid_params)
      assert is_map(data)
    end

    test "fails with missing required parameters" do
      # Missing PlayerID
      params = Keyword.delete(@valid_params, :PlayerID)
      assert {:error, _} = PlayerNextNGames.get(params)

      # Missing Season
      params = Keyword.delete(@valid_params, :Season)
      assert {:error, _} = PlayerNextNGames.get(params)
    end

    test "fails with invalid parameter types" do
      # NumberOfGames as string
      params = Keyword.put(@valid_params, :NumberOfGames, "five")
      assert {:error, _} = PlayerNextNGames.get(params)

      # Season with invalid pattern
      params = Keyword.put(@valid_params, :Season, "202425")
      assert {:error, _} = PlayerNextNGames.get(params)

      # SeasonType with invalid value
      params = Keyword.put(@valid_params, :SeasonType, "Midseason")
      assert {:error, _} = PlayerNextNGames.get(params)
    end

    test "handles unknown parameters gracefully" do
      params = Keyword.put(@valid_params, :UnknownParam, "foo")
      assert {:error, _} = PlayerNextNGames.get(params)
    end

    test "LeagueID is optional and defaults to '00' if not provided" do
      params = Keyword.delete(@valid_params, :LeagueID)
      assert {:ok, data} = PlayerNextNGames.get(params)
      assert is_map(data)
    end
  end
end
