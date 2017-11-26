defmodule Mhp.Server do
  use GenServer

  def start_link() do
    GenServer.start_link(Mhp.Server, %Mhp.State{}, name: Mhp.Server)
  end

  def handle_call(:new_game, _from, _state) do
    new_state = Mhp.Impl.new_game()
    {:reply, new_state, new_state}
  end

  def handle_call(:tally, _from, state) do
    new_state = Mhp.Impl.tally(state)
    {:reply, new_state, new_state}
  end

  def handle_call({:select_door, number}, _from, state) do
    new_state = Mhp.Impl.select_door(state, number)
    {:reply, new_state, new_state}
  end

  def handle_call({:stay_or_switch?, choice}, _from, state) do
    new_state = Mhp.Impl.stay_or_switch?(state, choice)
    {:reply, new_state, new_state}
  end

end