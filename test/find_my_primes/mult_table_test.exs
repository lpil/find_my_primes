defmodule FindMyPrimes.MultTableTest do
  use ExUnit.Case
  alias FindMyPrimes.MultTable
  doctest MultTable

  describe "calculate/1" do
    test "table of nothing" do
      assert MultTable.calculate([]) == []
    end

    test "table of 1 element" do
      assert MultTable.calculate([2]) == [[4]]
    end

    test "table of 2 elements" do
      assert MultTable.calculate([2, 4]) ==
        [[4, 8],
         [8, 16]]
    end

    test "table of 3 elements" do
      assert MultTable.calculate([2, 4, 9]) ==
        [[4, 8, 18],
         [8, 16, 36],
         [18, 36, 81]]
    end
  end

  describe "draw/1" do
    test "table of 1 number" do
      assert MultTable.draw([2]) == """
      |   | 2 |
      | 2 | 4 |
      """
    end

    test "table of 3 numbers" do
      assert MultTable.draw([2, 3, 5]) == """
      |    |  2 |  3 |  5 |
      |  2 |  4 |  6 | 10 |
      |  3 |  6 |  9 | 15 |
      |  5 | 10 | 15 | 25 |
      """
    end

  end
end
