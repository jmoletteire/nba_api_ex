defmodule NBA.Stats.CommonPlayoffSeriesTest do
  use ExUnit.Case

  alias NBA.Stats.CommonPlayoffSeries

  @valid_params [Season: "2024-25", LeagueID: "00"]
  @invalid_params [Season: "2024-25", LeagueID: "invalid"]

  describe "get/2" do
    test "returns data for valid parameters" do
      assert {:ok, data} = CommonPlayoffSeries.get(@valid_params)
      # IO.inspect(data, label: "CommonPlayoffSeries Data")
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = CommonPlayoffSeries.get(@invalid_params)
    end

    test "returns error for missing required parameters" do
      assert {:error, _reason} = CommonPlayoffSeries.get(LeagueID: "00")
    end
  end
end
