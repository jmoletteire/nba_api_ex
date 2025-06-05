defmodule NBA.Stats.PlayerVsPlayerTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.PlayerVsPlayer

  @valid_params [
    LastNGames: 5,
    MeasureType: "Base",
    Month: 0,
    OpponentTeamID: 1_610_612_737,
    PaceAdjust: "N",
    PerMode: "PerGame",
    Period: 0,
    PlayerID: 201_939,
    PlusMinus: "N",
    Rank: "N",
    Season: "2024-25",
    SeasonType: "Regular Season",
    VsPlayerID: 2544,
    LeagueID: "00"
  ]

  describe ".get/2" do
    test "returns data with valid parameters" do
      assert {:ok, data} = PlayerVsPlayer.get(@valid_params)
      assert is_map(data)
    end

    test "fails with missing required parameters" do
      required = [
        :PlayerID,
        :Season,
        :VsPlayerID
      ]

      Enum.each(required, fn param ->
        params = Keyword.delete(@valid_params, param)
        assert {:error, _} = PlayerVsPlayer.get(params)
      end)
    end

    test "fails with invalid parameter types or values" do
      # Invalid PerMode
      params = Keyword.put(@valid_params, :PerMode, "Per48Min")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid MeasureType
      params = Keyword.put(@valid_params, :MeasureType, "Efficiency")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid PaceAdjust
      params = Keyword.put(@valid_params, :PaceAdjust, "Maybe")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid PlusMinus
      params = Keyword.put(@valid_params, :PlusMinus, "X")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid Rank
      params = Keyword.put(@valid_params, :Rank, "Z")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid SeasonType
      params = Keyword.put(@valid_params, :SeasonType, "Midseason")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid VsDivision
      params = Keyword.put(@valid_params, :VsDivision, "CentralEast")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid VsConference
      params = Keyword.put(@valid_params, :VsConference, "North")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid Outcome
      params = Keyword.put(@valid_params, :Outcome, "Draw")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid Location
      params = Keyword.put(@valid_params, :Location, "Neutral")
      assert {:error, _} = PlayerVsPlayer.get(params)
      # Invalid GameSegment
      params = Keyword.put(@valid_params, :GameSegment, "Third Half")
      assert {:error, _} = PlayerVsPlayer.get(params)
    end

    test "handles nil and omitted nullable parameters" do
      nullable = [
        :VsDivision,
        :VsConference,
        :SeasonSegment,
        :Outcome,
        :Location,
        :GameSegment,
        :DateTo,
        :DateFrom
      ]

      params =
        Enum.reduce(nullable, @valid_params, fn param, acc -> Keyword.put(acc, param, nil) end)

      assert {:ok, data} = PlayerVsPlayer.get(params)
      assert is_map(data)

      params =
        Enum.reduce(nullable, @valid_params, fn param, acc -> Keyword.delete(acc, param) end)

      assert {:ok, data} = PlayerVsPlayer.get(params)
      assert is_map(data)
    end

    test "handles unknown parameters gracefully" do
      params = Keyword.put(@valid_params, :UnknownParam, "foo")
      assert {:error, _} = PlayerVsPlayer.get(params)
    end

    test "LeagueID is optional and defaults to '00' if not provided" do
      params = Keyword.delete(@valid_params, :LeagueID)
      assert {:ok, data} = PlayerVsPlayer.get(params)
      assert is_map(data)
    end
  end
end
