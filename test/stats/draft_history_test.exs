defmodule NBA.Stats.DraftHistoryTest do
  use ExUnit.Case
  alias NBA.Stats.DraftHistory

  @valid_params [Season: "2022", TeamID: 1_610_612_739]
  @invalid_params [InvalidParam: "test"]

  describe "get/2" do
    test "fetches draft history with default parameters" do
      assert {:ok, _data} = DraftHistory.get()
    end

    test "fetches draft history with specific season" do
      assert {:ok, _data} = DraftHistory.get(Season: "2022")
    end

    test "fetches draft history with team ID" do
      # Example team ID
      assert {:ok, _data} = DraftHistory.get(TeamID: 1_610_612_739)
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = DraftHistory.get(@invalid_params)
    end

    test "get!/2 returns data for valid parameters" do
      assert result = DraftHistory.get!(@valid_params)
      assert is_map(result)
    end
  end
end
