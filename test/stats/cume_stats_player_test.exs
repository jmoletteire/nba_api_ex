defmodule NBA.Stats.CumeStatsPlayerTest do
  use ExUnit.Case

  alias NBA.Stats.CumeStatsPlayer

  @valid_params [
    Season: "2024",
    SeasonType: "Playoffs",
    PlayerID: 1_630_169,
    GameIDs: "0042400305|0042400306"
  ]
  @invalid_params [
    GameIDs: "invalid",
    PlayerID: "not_a_number",
    Season: "2024",
    SeasonType: "Invalid"
  ]

  describe "get/2" do
    test "returns data for valid parameters" do
      assert {:ok, data} = CumeStatsPlayer.get(@valid_params)
      # IO.inspect(data, label: "CumeStatsPlayer Data")
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = CumeStatsPlayer.get(@invalid_params)
    end

    test "get!/2 returns data for valid parameters" do
      assert result = CumeStatsPlayer.get!(@valid_params)
      assert is_map(result)
    end
  end
end
