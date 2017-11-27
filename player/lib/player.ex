defmodule Player do

  defdelegate start(), to: Player.Impl
  
end
