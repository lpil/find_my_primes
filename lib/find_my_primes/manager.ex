defmodule FindMyPrimes.Manager do
  use GenServer
  alias FindMyPrimes.{Worker, TaskSupervisor}

  def start_link(opts) do
    name = opts[:name]
    GenServer.start_link(__MODULE__, [], name: name)
  end


  def table(n, timeout \\ 10_000) when is_integer(n) and n >= 1 do
    GenServer.call(__MODULE__, {:table, n}, timeout)
  end

  def async_table(n) when is_integer(n) and n >= 1 do
    ref = make_ref()
    GenServer.cast(__MODULE__, {:table, n, self(), ref})
    {:ok, ref}
  end

  #
  # Callbacks
  #

  def init(_) do
    {:ok, []}
  end

  def handle_call({:table, n}, from, state) do
    :ok = spawn_worker(fn-> Worker.reply_with_table(n, from) end)
    {:noreply, state}
  end

  def handle_cast({:table, n, from, ref}, state) do
    :ok = spawn_worker(fn-> Worker.send_table(n, from, ref) end)
    {:noreply, state}
  end

  defp spawn_worker(func) do
    {:ok, _} = Task.Supervisor.start_child(TaskSupervisor, func)
    :ok
  end
end
