defmodule Player.Impl do

  def start() do
    clear_terminal(0)
    IO.gets("  Simulate = 0 \n  Enter Choice: ")
    |> String.trim |> String.to_integer |> sim_or_play?()
  end
  
  defp sim_or_play?(0) do
    clear_terminal(0)
    execute_sim()
  end
  
  defp execute_sim() do
    IO.puts("  Simulating 100,000 games...")
    Mhp.sim_game()
    wait_on_sim()
  end
  
  defp wait_on_sim() do
    IO.gets("  Simulating Complete. Push ENTER to see results.")
    Mhp.sim_tally()
    |> display_tally()
  end
  
  defp display_tally(tally) do
    sim_tally_output(tally) |> IO.gets
    start()
  end
   
  defp clear_terminal(doors_type) do
    IO.write("\e[H\e[2J")
    banner() |> IO.puts
    draw_doors(doors_type) |> IO.puts
  end
  
  defp banner() do
    "+++++ Monty Hall Paradox +++++"
  end
  
  defp sim_tally_output(tally) do
  "
    Total Games Won By Switching:  #{tally.games_won_switch}
    Total Games Lost By Switching: #{tally.games_lost_switch}
    Total Games Won By Staying:    #{tally.games_won_stay}
    Total Games Lost By Staying:   #{tally.games_lost_stay}
    
  Press ENTER to start again
  "
end

  defp draw_doors(0) do
  "
     _____  _____  _____
    |     ||     ||     |
    |  1  ||  2  ||  3  |
    |o    ||o    ||o    |
    |     ||     ||     |
    |_____||_____||_____|

  "
  end

end