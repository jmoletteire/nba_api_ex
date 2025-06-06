defmodule NBA.PlayerAwardsTest do
  use ExUnit.Case
  alias NBA.Stats.PlayerAwards

  @moduledoc """
  Tests for the NBA.PlayerAwards module.
  You can run these tests using any of these commands:
  - mix test test/player_awards_test.exs
  - mix test test/player_awards_test.exs:{line_number}
  - mix test test/player_awards_test.exs --only integration
  - mix test test/player_awards_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching awards for a known player (LeBron James).
  - Fetching awards for a player with no awards (Chris Duhon).
  - Fetching awards for an unknown player ID.
  - Handling invalid input types (non-integer player ID).
  """

  @tag :integration
  test "#1) fetches awards for a known player" do
    # LeBron James
    player_id = 2544
    assert {:ok, result} = PlayerAwards.get(PlayerID: player_id)
    assert is_map(result)
    assert Map.has_key?(result, "All-NBA")
  end

  @tag :integration
  test "#2) fetches awards for a player with no awards" do
    # Chris Duhon
    player_id = 2768
    assert {:ok, result} = PlayerAwards.get(PlayerID: player_id)
    assert result == %{} or result == nil or map_size(result) == 0
  end

  @tag :integration
  test "#3) returns empty for nonexistent player ID" do
    invalid_id = 99_999_999
    assert {:ok, result} = PlayerAwards.get(PlayerID: invalid_id)
    assert result == %{} or result == nil or map_size(result) == 0
  end

  @tag :unit
  test "#4) handles invalid input type gracefully" do
    assert {:error, "Invalid type for PlayerID: got \"not_an_id\", accepts integer, string"} =
             PlayerAwards.get(PlayerID: "not_an_id")
  end

  @tag :integration
  test "test bang function" do
    assert result = PlayerAwards.get!(PlayerID: 2544)
    assert is_map(result)
    assert Map.has_key?(result, "All-NBA")
  end

  # @tag :integration
  # test "#5) fetch awards data via proxy" do
  #   assert {:ok, _result} =
  #            PlayerAwards.get(2544,
  #              connect_options: [
  #                # Set the proxy settings
  #                proxy_headers: [
  #                  {"proxy-authorization",
  #                   "Basic #{Base.encode64("brd-customer-hl_88e088f8-zone-splash_proxy-country-us:49gg3v1mhjtk")}"}
  #                ],
  #                proxy: {:http, "brd.superproxy.io", 33335, []},
  #                transport_opts: [verify: :verify_none]
  #              ]
  #            )
  # end
end
