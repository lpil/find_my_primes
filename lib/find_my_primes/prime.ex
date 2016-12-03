defmodule FindMyPrimes.Prime do
  @doc """
  Generate a list of primes of length n using the sieve of eratosthenes.

  Later this could be swapped out for a faster algorithm such as the
  sieve of atkin, but for now I'll move onto the next part.

  The list is ordered largest to smallest.
  """
  @spec list(non_neg_integer) :: integer
  def list(0) do
    []
  end
  def list(count) when is_integer(count) and count > 0 do
    list(count - 1, 3, [2])
  end



  defp list(0, _, primes) do
    primes
  end

  defp list(count, candidate, primes) do
    if prime?(candidate, primes) do
      list(count - 1, candidate + 2, [candidate|primes])
    else
      list(count, candidate + 2, primes)
    end
  end


  defp prime?(candidate, lesser_primes) do
    sqrt = :math.sqrt(candidate)
    prime?(candidate, lesser_primes, sqrt)
  end

  defp prime?(_candidate, [], _sqrt) do
    true
  end

  # Primes larger than the sqrt cannot be a factor.
  defp prime?(candidate, [largest_prime | lesser_primes], sqrt)
  when largest_prime > sqrt
  do
    prime?(candidate, lesser_primes, sqrt)
  end

  defp prime?(candidate, [largest_prime | lesser_primes], sqrt) do
    if factor?(candidate, largest_prime) do
      false
    else
      prime?(candidate, lesser_primes, sqrt)
    end
  end


  defp factor?(num, divider) do
    rem(num, divider) == 0
  end
end
