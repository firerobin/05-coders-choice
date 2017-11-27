defmodule Mhp.SubSupervisor do
  use Supervisor

  def start_link() do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  defp start_sim(1) do
    {:ok, server} = Supervisor.start_child(__MODULE__, worker(Mhp.Server, [], id: 1, restart: :temporary))
    Mhp.Server.sim_game(server)
  end

  defp start_sim(id) do
    {:ok, server} = Supervisor.start_child(__MODULE__, worker(Mhp.Server, [], id: id, restart: :temporary))
    Mhp.Server.sim_game(server)
    start_sim(id - 1)
  end

  defp start_game() do
    {:ok, server} = Supervisor.start_child(__MODULE__, worker(Mhp.Server, [], restart: :temporary))
    Mhp.Server.new_game(server)
  end

  def sim_game() do
    start_sim(100000)
  end
  
  def new_game() do
    start_game()
  end

  def init(_arg) do
    supervise([], strategy: :one_for_one)
  end

end