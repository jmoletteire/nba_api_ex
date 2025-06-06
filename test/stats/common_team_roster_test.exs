defmodule NBA.Stats.CommonTeamRosterTest do
  use ExUnit.Case

  alias NBA.Stats.CommonTeamRoster

  @valid_params [TeamID: 1_610_612_747, Season: "2022-23", LeagueID: "00"]
  @invalid_params [TeamID: "invalid", Season: "2022-23", LeagueID: "00"]
  @missing_params [Season: "2022-23", LeagueID: "00"]

  describe "get/2" do
    test "returns data for valid parameters" do
      assert {:ok, data} = CommonTeamRoster.get(@valid_params)
      # IO.inspect(data, label: "CommonTeamRoster Data")
    end

    test "returns error for invalid parameters" do
      assert {:error, _reason} = CommonTeamRoster.get(@invalid_params)
    end

    test "returns error for missing required parameters" do
      assert {:error, _reason} = CommonTeamRoster.get(@missing_params)
    end
  end
end
