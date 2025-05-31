defmodule NBA.Live.Scoreboard_Test do
  use ExUnit.Case
  alias NBA.Live.Scoreboard

  @moduledoc """
  Tests for the NBA.Live.Scoreboard module.
  You can run these tests using any of these commands:
  - mix test test/live/scoreboard_test.exs
  - mix test test/live/scoreboard_test.exs:{line_number}
  - mix test test/live/scoreboard_test.exs --only integration
  - mix test test/live/scoreboard_test.exs --only unit

  The tests cover the following scenarios:
  - Fetching live scoreboard data.
  """

  @tag :integration
  test "#1) fetches live scoreboard data" do
    assert {:ok, result} = Scoreboard.get()
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "gameId")
  end

  @tag :integration
  test "test bang function" do
    assert result = Scoreboard.get!()
    assert is_list(result)
    assert length(result) > 0
    assert Map.has_key?(hd(result), "gameId")
  end
end
