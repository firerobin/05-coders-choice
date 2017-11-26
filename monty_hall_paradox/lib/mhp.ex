defmodule Mhp do

  alias Mhp.Api

  defdelegate new_game(),               to: Api
  defdelegate select_door(number),      to: Api
  defdelegate stay_or_switch?(choice),  to: Api
  defdelegate tally(),                  to: Api

end