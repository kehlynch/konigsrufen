defmodule KrWeb.API.CardView do
  use KrWeb, :view

  def render_cards(cards) do
    Enum.map(cards, &render_card(&1))
  end

  def render_card(%{} = card) do
    Map.new()
    |> Map.put(:slug, card.slug)
    |> Map.put(:suit, card.suit)
    |> Map.put(:value, card.value)
    |> Map.put(:points, card.points)
  end

  def render_card(nil), do: nil
end
