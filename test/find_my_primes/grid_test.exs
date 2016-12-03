defmodule FindMyPrimes.GridTest do
  use ExUnit.Case, async: true
  alias FindMyPrimes.Grid
  doctest Grid

  describe "draw/2" do
    test "invalid with less than 1 column" do
      assert_raise FunctionClauseError, fn-> Grid.draw(["1", "2", "3"], 0) end
      assert_raise FunctionClauseError, fn-> Grid.draw(["1", "2", "3"], -1) end
    end

    test "empty grid of 1 column" do
      assert Grid.draw([], 1) == """
      |  |
      """
    end

    test "non-empty grid of 1 column" do
      contents = Enum.map(1..3, &to_string/1)
      assert Grid.draw(contents, 1) == """
      | 1 |
      | 2 |
      | 3 |
      """
    end

    test "non-empty grid of 2 columns" do
      contents = Enum.map(1..6, &to_string/1)
      assert Grid.draw(contents, 2) == """
      | 1 | 2 |
      | 3 | 4 |
      | 5 | 6 |
      """
    end

    test "non-empty grid of 3 columns" do
      contents = Enum.map(1..6, &to_string/1)
      assert Grid.draw(contents, 3) == """
      | 1 | 2 | 3 |
      | 4 | 5 | 6 |
      """
    end

    test "contents are padded to match largest width" do
      contents = Enum.map(9..10, &to_string/1)
      assert Grid.draw(contents, 2) == """
      |  9 | 10 |
      """
    end

    test "contents are shifted to the end if there are empty cells" do
      contents = Enum.map(1..2, &to_string/1)
      assert Grid.draw(contents, 3) == """
      |   | 1 | 2 |
      """
    end

    test "shifting 2 columns" do
      contents = Enum.map(1..2, &to_string/1)
      assert Grid.draw(contents, 4) == """
      |   |   | 1 | 2 |
      """
    end

    test "shifting 3 columns" do
      contents = Enum.map(1..2, &to_string/1)
      assert Grid.draw(contents, 5) == """
      |   |   |   | 1 | 2 |
      """
    end

    test "example from specification" do
      contents =
        [2, 3, 5, 2, 4, 6, 10, 3, 6, 9, 15, 5, 10, 15, 25] |> Enum.map(&to_string/1)
      assert Grid.draw(contents, 4) == """
      |    |  2 |  3 |  5 |
      |  2 |  4 |  6 | 10 |
      |  3 |  6 |  9 | 15 |
      |  5 | 10 | 15 | 25 |
      """
    end
  end
end
