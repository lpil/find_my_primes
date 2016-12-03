defmodule FindMyPrimesTest do
  use ExUnit.Case
  doctest FindMyPrimes

  describe "" do
    test "the truth" do
      assert FindMyPrimes.table(3) == """
      |    |  2 |  3 |  5 |
      |  2 |  4 |  6 | 10 |
      |  3 |  6 |  9 | 15 |
      |  5 | 10 | 15 | 25 |
      """
    end
  end
end
