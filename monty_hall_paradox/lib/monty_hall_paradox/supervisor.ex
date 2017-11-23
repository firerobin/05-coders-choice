defmodule Mhp.Supervisor do
  use Supervisor

  def start_link() do
    {:ok, _sup} = Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_worker(1) do
    {:ok, _worker} = Supervisor.child(__MODULE__, worker(Mhp.Server, [], id: id))
  end

  def start_worker(id) do
    {:ok, _worker} = Supervisor.start_child(__MODULE__, worker(Mhp.Server, [], id: id))
    start_worker(id - 1)
  end
  
  def new_game() do
    start_worker(1)
  end

  def sim_game() do
    start_worker(10000)
  end

  def init(_arg) do
    supervise([], strategy: :simply_one_for_one)
  end

end