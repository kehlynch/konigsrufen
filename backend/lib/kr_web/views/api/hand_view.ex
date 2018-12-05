defmodule KrWeb.API.HandView do
  use KrWeb, :view

  alias KrWeb.API.CardView

  def render_hands(%{} = hands) do
    Map.new()
    |> Map.put(:p1, render_hand(hands.p1))
    |> Map.put(:p2, render_hand(hands.p2))
    |> Map.put(:p3, render_hand(hands.p3))
    |> Map.put(:p4, render_hand(hands.p4))
  end

  def render_hand(%{} = hand) do
    Map.new()
    |> Map.put(:trumps, render_cards(hand, :trump))
    |> Map.put(:clubs, render_cards(hand, :club))
    |> Map.put(:diamonds, render_cards(hand, :diamond))
    |> Map.put(:hearts, render_cards(hand, :heart))
    |> Map.put(:spades, render_cards(hand, :spade))
  end

  defp render_cards(cards, suit) do
    cards
    |> Map.get(suit)
    |> do_render_cards()
  end

  defp do_render_cards(nil), do: []
  defp do_render_cards(cards), do: CardView.render_cards(cards)
end
