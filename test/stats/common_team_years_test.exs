defmodule NBA.Stats.CommonTeamYearsTest do
  use ExUnit.Case

  alias NBA.Stats.CommonTeamYears

  @valid_params [LeagueID: "00"]
  @invalid_params [LeagueID: "invalid"]

  describe "get/2" do
    test "returns data for valid parameters" do
      assert {:ok, data} = CommonTeamYears.get(@valid_params)
      # IO.inspect(data, label: "CommonTeamYears Data")
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = CommonTeamYears.get(@invalid_params)
    end
  end
end
