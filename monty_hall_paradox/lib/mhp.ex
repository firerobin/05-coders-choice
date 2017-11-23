defmodule Mhp do

  alias Mhp.Supervisor
  alias Mhp.Server
  
  defdelegate new_game(),                     to: Supervisor
  defdelegate sim_game(),                     to: Supervisor
  defdelegate select_door(game, number),      to: Api
  defdelegate stay_or_switch?(game, choice),  to: Api
  defdelegate tally(game),                    to: Api

end
