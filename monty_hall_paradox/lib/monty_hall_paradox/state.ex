defmodule Mhp.State do
  use GenServer

  defstruct {
    game_state:       :initializing,
    stay_or_switch?:  :not_decided
    doors:            [:goat, :goat, :goat]
    goat_door:        -1
    choice:           -1
    games_played:     0
    games_won_stay:   0
    games_won_switch: 0
  }

  def start_link(args) do
    Agent.start_link(fn -> %Mhp.State{} end, name: __MODULE__)
  end

end