defmodule Mhp.Server do

use GenServer

  def handle_call(:new_game, _from, state) do
    {:reply, Mhp.Impl.new_game(), state}
  end

  def handle_call(:tally, _from, state)
    {:reply, Mhp.Impl.tally(), state}
  end

  def handle_call({:select_door, number}, _from, state) do
    {:reply, Mhp.Impl.select_door(number), state}
  end

  def handle_call({:stay_or_switch?, choice}, _from, state) do
    {:reply, Mhp.Impl.stay_or_switch?(choice), state}
  end

  def handle_cast(:sim_game, _from, state)
    {:stop, Mhp.Impl.sim_game(), state}
  end

end