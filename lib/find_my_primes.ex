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
