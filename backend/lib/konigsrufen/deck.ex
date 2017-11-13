defmodule Konigsrufen.Deck do
  alias Konigsrufen.{Suit, Card}

  @trump_suit Suit.init(name: "Trump", is_trump: true)
  @non_trump_suits [
    Suit.init(name: "Spade"),
    Suit.init(name: "Club"),
    Suit.init(name: "Heart", pip_reverse: true),
    Suit.init(name: "Diamond", pip_reverse: true),
  ]

  def get_deck do
    trumps =
      1..22
      |> Enum.map(&(Card.get_card(@trump_suit, &1)))

    non_trumps =
      1..8
      |> Enum.map(fn(value) ->
        @non_trump_suits
        |> Enum.map(fn(suit) ->
          Card.get_card(suit, value)
        end) 
      end)
      |> List.flatten

    trumps ++ non_trumps
  end

  def get_hands do
    {talon, hands} = 
      get_deck()
      |> Enum.shuffle
      |> Enum.chunk_every(12, 12, [])
      |> List.pop_at(-1)
    %{hands: hands, talon: talon}
  end
end
