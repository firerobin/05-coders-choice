defmodule Mhp do

  alias Mhp.Supervisor
  alias Mhp.Server
  
  defdelegate new_game(),                     to: Supervisor
  defdelegate select_door(game, number),      to: Server
  defdelegate stay_or_switch?(game, answer),  to: Server
  defdelegate result(),                       to: Server

end
