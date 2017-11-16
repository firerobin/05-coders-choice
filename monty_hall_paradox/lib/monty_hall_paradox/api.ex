defmodule Mhp.Api do
  
  @server MhpServer

  def start_link() do
    GenServer.start_link(Mhp.Server, nil, name: @server)
  end
  
  def new_game() do
    GenServer.call(@server, {:new_game))
  end
  
  def select_door(number) do
    GenServer.call(@server, {:select_door, number})
  end
  
  def stay_or_switch?(answer) do
    GenServer.call(@server, {:stay_or_switch?, answer})
  end
  
  def result() do
    GenServer.call(@server, :result)
  end

end