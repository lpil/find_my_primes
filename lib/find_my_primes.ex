defmodule FindMyPrimes do
  use Application
  alias FindMyPrimes.Manager

  defdelegate table(n), to: Manager
  defdelegate async_table(n), to: Manager

  #
  # Callbacks
  #

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      supervisor(Task.Supervisor, [[name: FindMyPrimes.TaskSupervisor]]),
      worker(FindMyPrimes.Manager, [[name: FindMyPrimes.Manager]])
    ]
    opts = [strategy: :one_for_one, name: FindMyPrimes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule FindMyPrimes.Manager do
  use GenServer
  alias FindMyPrimes.{Worker, TaskSupervisor}

  def start_link(opts) do
    name = opts[:name]
    GenServer.start_link(__MODULE__, [], name: name)
  end


  def table(n) when is_integer(n) and n >= 1 do
    GenServer.call(__MODULE__, {:table, n})
  end

  def async_table(n) when is_integer(n) and n >= 1 do
    GenServer.cast(__MODULE__, {:table, n, self()})
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

  def handle_cast({:table, n, from}, state) do
    :ok = spawn_worker(fn-> Worker.send_table(n, from) end)
    {:noreply, state}
  end

  defp spawn_worker(func) do
    {:ok, _} = Task.Supervisor.start_child(TaskSupervisor, func)
    :ok
  end
end


defmodule FindMyPrimes.Worker do
  alias FindMyPrimes.{Prime, MultTable}

  def reply_with_table(num, target) do
    GenServer.reply(target, table(num))
  end

  def send_table(num, target) do
    send target, table(num)
  end

  defp table(num) do
    num
    |> Prime.list
    |> Enum.reverse
    |> MultTable.draw
  end
end
