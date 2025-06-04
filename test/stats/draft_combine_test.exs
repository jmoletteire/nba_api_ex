defmodule NBA.Stats.DraftCombineTest do
  use ExUnit.Case
  alias NBA.Stats.DraftCombine

  @valid_params [SeasonYear: "2023"]
  @invalid_params [InvalidKey: "value"]

  describe "get/2" do
    test "fetches anthro data successfully" do
      assert {:ok, _response} = DraftCombine.get(:anthro, @valid_params)
    end

    test "fetches drills data successfully" do
      assert {:ok, _response} = DraftCombine.get(:drills, @valid_params)
    end

    test "fetches spot shooting data successfully" do
      assert {:ok, _response} = DraftCombine.get(:spot, @valid_params)
    end

    test "fetches stats data successfully" do
      assert {:ok, _response} = DraftCombine.get(:stats, @valid_params)
    end

    test "fetches non-stationary shooting data successfully" do
      assert {:ok, _response} = DraftCombine.get(:nonstationary, @valid_params)
    end

    test "returns error for invalid type" do
      assert {:error, _reason} = DraftCombine.get(:invalid_type, @valid_params)
    end

    test "returns error for missing required parameters" do
      assert {:error, _reason} = DraftCombine.get(:anthro, [])
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = DraftCombine.get(:anthro, @invalid_params)
    end

    test "returns error for unsupported endpoint" do
      assert {:error, _reason} = DraftCombine.get(:unsupported, @valid_params)
    end

    test "get!/2 returns data for valid parameters" do
      assert result = DraftCombine.get!(:anthro, @valid_params)
      assert is_map(result)
    end
  end
end
