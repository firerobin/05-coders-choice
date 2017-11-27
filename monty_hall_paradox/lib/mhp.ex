defmodule Mhp do

  alias Mhp.SubSupervisor
  alias Mhp.Server

  defdelegate sim_game(),                   to: SubSupervisor
  defdelegate new_game(),                   to: SubSupervisor
  defdelegate select_door(pid, number),     to: Server
  defdelegate stay_or_switch?(pid, choice), to: Server
  defdelegate tally(pid),                   to: Server
  defdelegate sim_tally(),                  to: Server

end