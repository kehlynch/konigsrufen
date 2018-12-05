defmodule Kr.Decks do
  alias Kr.{Cards, Hands}

  @type deck :: %{
    required(:hands) => Hands.hands(),
    required(:talon) => Cards.cardlist()
  }

  @spec deal() :: deck()
  def deal() do
    cards = get_trumps() ++ get_nontrumps()

    {talon, hand_cards} = 
      cards
      |> Enum.shuffle
      |> Enum.chunk_every(12, 12, [])
      |> List.pop_at(-1)

    Map.new()
    |> Map.put(:hands, Hands.build_hands(hand_cards))
    |> Map.put(:talon, talon)
  end

  @spec get_trumps() :: Cards.cardlist()
  defp get_trumps() do
    1..22
    |> Enum.map(&Cards.get_card(:trump, &1))
  end

  @spec get_nontrumps() :: Cards.cardlist()
  defp get_nontrumps() do
    [:heart, :diamond, :spade, :club]
    |> Enum.map(&get_nontrumps(&1))
    |> List.flatten()
  end

  @spec get_nontrumps(Cards.suit()) :: Cards.cardlist()
  defp get_nontrumps(suit) do
    1..8
    |> Enum.map(&Cards.get_card(suit, &1))
  end
end
