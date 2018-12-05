defmodule KrWeb.API.DeckView do
  use KrWeb, :view

  alias KrWeb.API.{CardView, HandView}

  def render("show.json", %{deck: deck}) do
    render_deck(deck)
  end

  def render_deck(deck) do
    Map.new()
    |> Map.put(:p1, HandView.render_hand(deck.p1))
    |> Map.put(:p2, HandView.render_hand(deck.p2))
    |> Map.put(:p3, HandView.render_hand(deck.p3))
    |> Map.put(:p4, HandView.render_hand(deck.p4))
    |> Map.put(:talon, CardView.render_cards(deck.talon))
  end
end
