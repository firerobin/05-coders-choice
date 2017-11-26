defmodule Mhp.Impl do

  def new_game(%Mhp.State{} = game, random_door) do
    %Mhp.State{ doors: List.update_at(game.doors, random_door, fn _x -> :car end) }
  end
  
  def new_game() do
    %Mhp.State{}
    |> new_game(Enum.random(0..2))
  end
  
#  def sim_game() do
#    Mhp.new_game()
#    |> select_door(Enum.random(0..2))
#    |> Mhp.stay_or_switch?(Enum.random(0..1))
#  end
    
  def tally(%Mhp.State{} = game) do
    Map.drop(game, [:doors])
    |> Map.from_struct
    |> IO.inspect
  end

  def select_door(%Mhp.State{selected_door: -1} = game, number) when (number == 0 or number == 1 or number == 2) do
    random_door = Enum.random(0..2)
    %Mhp.State{ game | selected_door: number }
    |> open_goat_door(random_door, Enum.at(game.doors, random_door))
  end
  
  defp open_goat_door(%Mhp.State{selected_door: selected_door} = game, door, :goat) when door != selected_door do
    %Mhp.State{ game | state: :goat_door_open, goat_door: door }
  end
  
  defp open_goat_door(%Mhp.State{} = game, _door, _behind_door) do
    random_door = Enum.random(0..2)
    game |> open_goat_door(random_door, Enum.at(game.doors, random_door))
  end

  def stay_or_switch?(%Mhp.State{} = game, 0) do
    %Mhp.State{ game | stay_or_switch?: :stay }
    |> result( Enum.at(game.doors, game.selected_door) )
  end
  
  def stay_or_switch?(%Mhp.State{} = game, 1) do
    %Mhp.State{ game | stay_or_switch?: :switch }
    |> switch_door(game.selected_door + game.goat_door)
    |> result()
  end
  
  defp switch_door(%Mhp.State{} = game, 1) do
    %Mhp.State{ game | selected_door: 2 }
  end
  
  defp switch_door(%Mhp.State{} = game, 2) do
    %Mhp.State{ game | selected_door: 1 }
  end
  
  defp switch_door(%Mhp.State{} = game, 3) do
    %Mhp.State{ game | selected_door: 0 }
  end
  
  defp result(%Mhp.State{} = game) do
    game |> result( Enum.at(game.doors, game.selected_door) )
  end
  
  defp result(%Mhp.State{stay_or_switch?: :stay} = game, :car) do
    %Mhp.State{ game | state: :won }
#      state: :won, games_won_stay: game.games_won_stay + 1 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :switch} = game, :car) do
    %Mhp.State{ game | state: :won }
#      state: :won, games_won_switch: game.games_won_switch + 1 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :stay} = game, :goat) do
    %Mhp.State{ game | state: :lost }
#      state: :lost, games_lost_stay: game.games_lost_stay + 1 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :switch} = game, :goat) do
    %Mhp.State{ game | state: :lost }
#      state: :lost, games_lost_switch: game.games_lost_switch + 1 }
  end

end