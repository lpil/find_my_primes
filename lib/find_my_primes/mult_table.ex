defmodule FindMyPrimes.MultTable do

  alias FindMyPrimes.{Grid}

  @doc """
  Calculate a multiplication table for a given list of numbers.
  """
  @spec calculate([number]) :: [[number]]
  def calculate(nums) when is_list(nums) do
    Enum.map(nums, fn(num) ->
      Enum.map(nums, & num * &1)
    end)
  end


  @doc """
  Calculate a multiplication table and render as a string.
  """
  @spec draw([number]) :: String.t
  def draw(nums) when is_list(nums) do
    table =
      calculate(nums)
      |> Enum.zip(nums)
      |> Enum.map(fn({xs, x}) -> [x | xs] end)
      |> List.flatten
      |> Enum.map(&to_string/1)
    header = Enum.map(["" | nums], &to_string/1)
    num_cols = length(nums) + 1
    Grid.draw(header ++ table, num_cols)
  end
end
