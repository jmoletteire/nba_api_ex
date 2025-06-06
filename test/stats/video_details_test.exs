defmodule NBA.Stats.VideoDetailsTest do
  use ExUnit.Case, async: true
  alias NBA.Stats.VideoDetails

  @valid_params [
    ContextMeasure: "FGM",
    LastNGames: 5,
    Month: 1,
    OpponentTeamID: 1_610_612_737,
    Period: 1,
    PlayerID: 201_939,
    Season: "2024-25",
    SeasonType: "Regular Season",
    TeamID: 1_610_612_744
  ]

  @invalid_params [
    ContextMeasure: "INVALID",
    LastNGames: -1,
    Month: 13,
    OpponentTeamID: "foo",
    Period: 10,
    PlayerID: "bar",
    Season: 202_425,
    SeasonType: "Midseason",
    TeamID: "baz"
  ]

  @unknown_params [
    RandomParam: "invalid",
    ContextMeasure: "FGM"
  ]

  describe "get/2" do
    test "returns video details data with valid parameters" do
      assert {:ok, response} = VideoDetails.get(@valid_params)
      assert is_map(response)
    end

    test "get!/2 returns video details data with valid parameters" do
      assert response = VideoDetails.get!(@valid_params)
      assert is_map(response)
    end

    test "returns error for missing required parameters" do
      assert {:error, "Missing required parameter(s): :PlayerID, :Season" <> _} =
               VideoDetails.get([])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = VideoDetails.get(@invalid_params)
    end

    test "returns error for unknown parameters" do
      assert {:error, _reason} = VideoDetails.get(@unknown_params)
    end

    test "LeagueID is optional and defaults to '00' if not provided" do
      params = Keyword.delete(@valid_params, :LeagueID)
      assert {:ok, response} = VideoDetails.get(params)
      assert is_map(response)
    end

    test "nullable/optional parameters are handled correctly" do
      params =
        Keyword.merge(@valid_params,
          VsDivision: nil,
          VsConference: nil,
          StartRange: nil,
          EndRange: nil
        )

      assert {:ok, response} = VideoDetails.get(params)
      assert is_map(response)
    end
  end
end
