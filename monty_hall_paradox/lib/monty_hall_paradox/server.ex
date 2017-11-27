defmodule Mhp.Server do

use GenServer

  #####
  # External API

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, :not_done)
  end

  def sim_game(pid) do
    GenServer.cast(pid, :sim_game)
  end

  def new_game(pid) do
    GenServer.call(pid, :new_game)
  end
  
  def select_door(pid, number) do
    GenServer.call(pid, {:select_door, number})
  end

  def stay_or_switch?(pid, choice) do
    GenServer.call(pid, {:stay_or_switch?, choice})
  end

  def tally(pid) do
    GenServer.call(pid, :tally)
  end

  def sim_tally() do
    GenServer.call(Mhp.State, :sim_tally)
  end

  #####
  # GenServer Implementation

  def handle_cast(:sim_game, _state) do
    new_state = Mhp.Impl.sim_game()
    Mhp.State.sim_update(new_state.state, new_state.stay_or_switch?)
    {:stop, :shutdown, :done}
  end

  def handle_call(:new_game, _from, _state) do
    new_state = Mhp.Impl.new_game()
    {:reply, self(), new_state}
  end

  def handle_call(:tally, _from, state) do
    new_state = Mhp.Impl.tally(state)
    {:reply, self(), new_state}
  end

  def handle_call({:select_door, number}, _from, state) do
    new_state = Mhp.Impl.select_door(state, number)
    {:reply, self(), new_state}
  end

  def handle_call({:stay_or_switch?, choice}, _from, state) do
    new_state = Mhp.Impl.stay_or_switch?(state, choice)
    {:reply, self(), new_state}
  end

  def handle_call(:sim_tally, _from, state) do
    tally = Mhp.State.sim_tally()
    {:reply, tally, state}
  end

end