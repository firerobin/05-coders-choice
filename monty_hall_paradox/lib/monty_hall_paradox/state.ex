defmodule Mhp.State do
  use GenServer

  defstruct(
    state:              :initializing,
    stay_or_switch?:    :not_decided,
    doors:              [:goat, :goat, :goat],
    goat_door:          -1,
    selected_door:      -1,
    games_won_stay:     0,
    games_won_switch:   0,
    games_lost_stay:    0,
    games_lost_switch:  0
  )
  
  #####
  # External API
  
  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, %Mhp.State{}, name: __MODULE__)
  end
  
  def sim_update(state, stay_or_switch?) do
    GenServer.cast(__MODULE__, {:sim_update, state, stay_or_switch?})
  end
  
  def sim_tally() do
    GenServer.cast(__MODULE__, :sim_tally)
  end
  
  #####
  # GenServer Implementation

  def handle_cast({:sim_update, :won, :stay}, sim_state) do
    {:noreply, Map.update!(sim_state, :games_won_stay, &(&1 + 1))}
  end
  
  def handle_cast({:sim_update, :won, :switch}, sim_state) do
    {:noreply, Map.update!(sim_state, :games_won_switch, &(&1 + 1))}
  end
  
  def handle_cast({:sim_update, :lost, :stay}, sim_state) do
    {:noreply, Map.update!(sim_state, :games_lost_stay, &(&1 + 1))}
  end
  
  def handle_cast({:sim_update, :lost, :switch}, sim_state) do
    {:noreply, Map.update!(sim_state, :games_lost_switch, &(&1 + 1))}
  end
  
  def handle_call(:sim_tally, _from, sim_state) do
    {:reply,
      %{games_won_stay:     sim_state.games_won_stay,
        games_won_switch:   sim_state.games_won_switch,
        games_lost_stay:    sim_state.games_lost_stay,
        games_lost_switch:  sim_state.games_lost_switch}, sim_state }
  end

end