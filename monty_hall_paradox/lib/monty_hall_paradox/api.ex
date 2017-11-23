defmodule Mhp.Api do
  
  @server Mhp.Server

  def start_link() do
    GenServer.start_link(Mhp.Server, nil, name: @server)
  end
  
  def new_game() do
    GenServer.call(@server, {:new_game})
  end
  
  def select_door(number) do
    GenServer.call(@server, {:select_door, number})
  end
  
  def stay_or_switch?(choice) do
    GenServer.call(@server, {:stay_or_switch?, choice})
  end
  
  def sim_game() do
    GenServer.call(@server, :sim_game)
  end
  
  def tally() do
    GenServer.call(@server, :tally)
  end

end