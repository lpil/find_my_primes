defmodule FindMyPrimes.PrimeTest do
  use ExUnit.Case, async: true
  alias FindMyPrimes.Prime
  doctest Prime

  describe "list/1" do
    test "0 primes" do
      assert Prime.list(0) == []
    end

    test "1 prime" do
      assert Prime.list(1) == [2]
    end

    test "2 primes" do
      assert Prime.list(2) == [3, 2]
    end

    test "6 primes" do
      assert Prime.list(6) == [13, 11, 7, 5, 3, 2]
    end

    test "100 primes" do
      primes = Prime.list(100)
      assert hd(primes) == 541
      assert length(primes) == 100
    end

    test "1000 primes" do
      primes = Prime.list(1000)
      assert hd(primes) == 7919
      assert length(primes) == 1000
    end

    @tag :slow
    test "2000 primes" do
      primes = Prime.list(2000)
      assert hd(primes) == 17389
      assert length(primes) == 2000
    end

    @tag :slow
    test "10,000 primes" do
      primes = Prime.list(10_000)
      assert hd(primes) == 104729
      assert length(primes) == 10_000
    end

    test "cannot construct a list of negative length" do
      assert_raise FunctionClauseError, fn-> Prime.list(-1) end
    end
  end
end
