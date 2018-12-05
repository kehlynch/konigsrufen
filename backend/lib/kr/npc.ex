defmodule Kr.NPC do
  alias Kr.{Players, Cards, Hands, Tricks}

  @spec get_card(pid(), Players.player()) :: Cards.card()
  def get_card(pid, player) do
    hand = Hands.get_hand(pid, player)

    pid
    |> Tricks.get_last_card()
    |> get_random_legal(hand)
  end

  @spec get_random_legal(Cards.card() | nil, Hands.hand()) :: Cards.card()
  defp get_random_legal(nil, hand) do
    hand
    |> maybe_remove_pagat()
    |> Map.values()
    |> List.flatten()
    |> Enum.random()
  end

  defp get_random_legal(%{suit: suit, value: value}, hand) do
    case Map.get(hand, suit) do
      [] -> get_random_legal(nil, hand)
      cards -> get_playup_legal(cards, value)
    end
  end

  @spec maybe_remove_pagat(Hands.hand()) :: Hands.hand()
  defp maybe_remove_pagat(%{trump: trumps} = hand) when length(trumps) <= 1 do
    hand
  end

  defp maybe_remove_pagat(%{trump: trumps} = hand) do
    filtered_trumps = 
      trumps
      |> Enum.reject(& &1.slug === :trump1)

    Map.put(hand, :trump, filtered_trumps)
  end

  @spec get_playup_legal(Cards.cardlist(), Cards.value()) :: Cards.card()
  defp get_playup_legal(cards, value) do
    case Enum.filter(cards, &(&1.value > value)) do
      []  -> Enum.random(cards)
      legal_cards -> Enum.random(legal_cards)
    end
  end
end
