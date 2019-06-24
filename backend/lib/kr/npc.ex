defmodule Kr.NPC do
  alias Kr.{Players, Cards, Hands}

  @spec get_card(pid(), Players.player()) :: Cards.card()
  def get_card(pid, player) do
    pid
    |> Hands.get_legal_cards(player)
    |> Enum.random()
  end
end
