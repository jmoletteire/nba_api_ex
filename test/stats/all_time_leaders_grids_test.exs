defmodule NBA.Stats.AllTimeLeadersGridsTest do
  use ExUnit.Case

  alias NBA.Stats.AllTimeLeadersGrids

  @valid_params [LeagueID: "00", SeasonType: "Regular Season", PerMode: "Totals", TopX: 10]
  @invalid_params [LeagueID: "invalid", SeasonType: "Invalid", PerMode: "Invalid", TopX: -1]

  describe "get/2" do
    test "returns data for valid parameters" do
      assert {:ok, data} = AllTimeLeadersGrids.get(@valid_params)
      IO.inspect(data, label: "AllTimeLeaderGrids Data")
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = AllTimeLeadersGrids.get(@invalid_params)
    end

    test "get!/2 returns data for valid parameters" do
      assert result = AllTimeLeadersGrids.get!(@valid_params)
      assert is_map(result)
      assert Map.has_key?(result, "ASTLeaders")
    end
  end
end
