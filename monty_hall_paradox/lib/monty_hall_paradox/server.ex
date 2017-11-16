defmodule Mhp.Server do
  
  def handle_call(:new_game, _from, state) do
    {:reply, Mph.new_game(), state}
  end
  
  def handle_call({:select_door, number}, _from, state) do
    {:reply, Mph.Impl.select_door(number), state}
  end
  
  def handle_call({:stay_or_switch?, answer}, _from, state) do
    {:reply, Mph.Impl.stay_or_switch?(answer), state}
  end
  
  def handle_call(:result, _from, state)
    {:reply, Mph.Impl.result(), state}
  end
  
end
  