defmodule FindMyPrimes.Grid do

  @doc """
  Given a list of strings and a number of a columns draw a grid containing the strings.
  """
  @spec draw([String.t], non_neg_integer) :: String.t
  def draw(content, cols) when cols > 0 do
    {max_width, size} = max_width_and_length(content)
    padding = content_padding(cols, size)
    lines =
      padding
      ++ content
      |> Enum.map(&String.pad_leading(&1, max_width))
      |> Enum.chunk(cols)
      |> Enum.map(&Enum.intersperse(&1, " | "))
      |> Enum.intersperse(" |\n| ")
    IO.iodata_to_binary(["| ", lines, " |\n"])
  end

  defp max_width_and_length(contents) do
    max_width_and_length(contents, 0, 0)
  end
  defp max_width_and_length([], max_width, count) do
    {max_width, count}
  end
  defp max_width_and_length([x | xs], max_width, count) do
    new_max = x |> String.length() |> max(max_width)
    max_width_and_length(xs, new_max, count + 1)
  end

  defp content_padding(num_cols, num_items) do
    overlap = rem(num_items, num_cols)
    padding_size = case overlap do
      0 -> 0
      n -> num_cols - overlap
    end
    List.duplicate("", padding_size)
  end
end
