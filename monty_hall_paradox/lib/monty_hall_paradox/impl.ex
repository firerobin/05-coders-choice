defmodule Mhp.Impl do

  def new_game(random_door) do
    %Mhp.State{ game |
      doors: List.update_at(game.doors, random_door, :car) }
  end
  
  def new_game() do
    Enum.random(0..2)
    |> new_game()
  end
  
  def sim_game() do
    Mhp.new_game()
    |> select_door(Enum.random(0..2))
    |> Mhp.stay_or_switch?(Enum.random(0..1))
  end
    
  def tally(%Mhp.State{} = game) do
    %{game}
  end

  def select_door(%Mhp.State{selected_door: -1} = game, number) when number in [0..2] do
    %Mhp.State{ game | selected_door: number }
    |> open_goat_door(random_door = Enum.random(0..2), Enum.at(random_door))
  end
  
  defp open_goat_door(%Mhp.State{selected_door: selected_door} = game, door, :goat) when door != selected_door do
    %Mhp.State{ game | state: :goat_door_open, goat_door: door )
  end
  
  defp open_goat_door(%Mhp.State{} = game, _door, _behind_door) do
    game
    |> open_goat_door(random_door = Enum.random(0..2), Enum.at(random_door))
  end

  def stay_or_switch?(%Mhp.State{} = game, choice = 0) do
    %Mhp.State{ game | stay_or_switch?: :stay }
    |> result( Enum.at(game.doors, game.selected_door) )
  end
  
  def stay_or_switch?(%Mhp.State{} = game, choice = 1) do
    %Mhp.State{ game | stay_or_switch?: :switch }
    |> switch_door(game, game.selected_door, game.goat_door)
    |> result( Enum.at(game.doors, game.selected_door) )
  end
  
  defp switch_door(%Mhp.State{} = game, 0, 1) do
    %Mhp.State{ game | selected_door: 2 }
  end
  
  defp switch_door(%Mhp.State{} = game, 0, 2) do
    %Mhp.State{ game | selected_door: 1 }
  end
  
  defp switch_door(%Mhp.State{} = game, 1, 2) do
    %Mhp.State{ game | selected_door: 0 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :stay} = game, :car) do
    %Mhp.State{ game |
      state: :won, games_won_stay: game.games_won_stay + 1 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :switch} = game, :car) do
    %Mhp.State{ game |
      state: :won, games_won_switch: game.games_won_switch + 1 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :stay} = game, :goat) do
    %Mhp.State{ game |
      state: :lost, games_lost_stay: game.games_lost_stay + 1 }
  end
  
  defp result(%Mhp.State{stay_or_switch?: :switch} = game, :goat) do
    %Mhp.State{ game |
      state: :lost, games_lost_switch: game.games_lost_switch + 1 }
  end

end