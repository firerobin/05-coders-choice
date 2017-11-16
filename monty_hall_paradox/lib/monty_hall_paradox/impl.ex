defmodule Mhp.Impl do

  def new_game(random_door) do
    %Mhp.State{ game |
      doors: List.update_at(game.doors, random_door, :car)
    }
  end
  
  def new_game() do
    Enum.random(0..2)
    |> new_game()
  end

  def select_door(%Mhp.State{selected_door: -1} = game, number) when number in [0..2] do
    %Mhp.State{game | state: :goat_door_open, selected_door: number}
    |> open_goat_door(random_door = Enum.random(0..2), Enum.at(random_door))
  end
  
  def open_goat_door(%Mhp.State{} = game, door != game.selected_door, :goat) do
    %Mhp.State{ game | goat_door: door )
  end
  
  def open_goat_door(%Mhp.State{} = game, _door, _behind_door) do
    game |> open_goat_door(random_door = Enum.random(0..2), Enum.at(random_door))
  end

  def stay_or_switch?(%Mhp.State{} = game, answer = "stay") do
    %Mhp.State{ game | stay_or_switch?: :stay }
    |> result(Enum.at(game.doors, game.selected_door))
  end
  
  def stay_or_switch?(%Mhp.State{} = game, answer = "switch") do
    %Mhp.State{ game | stay_or_switch?: :switch }
    |> switch_to_door(0)
    |> result(
  end
  
  defp switch_to_door(%Mhp.State{} = game, game.selected_door) do
    switch_to_door(game, game.selected_door + 1)
  end
  
  defp switch_to_door(%Mhp.State{} = game, game.goat_door) do
    switch_to_door(game, game.goat_door + 1)
  end
  
  defp switch_to_door(%Mhp.State{} = game, door) do
    %Mhp.State{ game | selected_door: door}
  end
  
  defp result(%Mhp.State{selected_door: :car, stay_or_switch?: :stay} = game) do
    %Mhp.State{ game |
      state:          :won,
      games_won:      game.games_won + 1,
      games_won_stay: games.games_won_stay + 1 }
  end
  
  defp result(%Mhp.State{} = game, :goat) do
    %Mhp.State{ game | state: :lost }
  end

end