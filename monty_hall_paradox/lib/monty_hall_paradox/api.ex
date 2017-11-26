defmodule Mhp.Api do

  @server Mhp.Server

  def new_game() do
    GenServer.call(@server, :new_game)
  end
  
  def select_door(number) do
    GenServer.call(@server, {:select_door, number})
  end

  def stay_or_switch?(choice) do
    GenServer.call(@server, {:stay_or_switch?, choice})
  end

  def tally() do
    GenServer.call(@server, :tally)
  end

end