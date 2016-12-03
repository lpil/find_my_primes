defmodule FindMyPrimes.Worker do
  alias FindMyPrimes.{Prime, MultTable}

  def reply_with_table(num, target) do
    GenServer.reply(target, table(num))
  end

  def send_table(num, target, ref) do
    send target, {:prime_table, ref, table(num)}
  end

  defp table(num) do
    num
    |> Prime.list
    |> Enum.reverse
    |> MultTable.draw
  end
end
