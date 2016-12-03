defmodule FindMyPrimesTest do
  use ExUnit.Case
  doctest FindMyPrimes

  describe "table/1" do
    test "table is computed and client waits for reply" do
      assert FindMyPrimes.table(3) == """
      |    |  2 |  3 |  5 |
      |  2 |  4 |  6 | 10 |
      |  3 |  6 |  9 | 15 |
      |  5 | 10 | 15 | 25 |
      """
    end
  end

  describe "async_table/1" do
    test "table is computed and client does not wait for reply" do
      assert {:ok, ref} = FindMyPrimes.async_table(3)
      assert is_reference(ref)
      assert_receive {:prime_table, ^ref, """
      |    |  2 |  3 |  5 |
      |  2 |  4 |  6 | 10 |
      |  3 |  6 |  9 | 15 |
      |  5 | 10 | 15 | 25 |
      """}
    end
  end
end
