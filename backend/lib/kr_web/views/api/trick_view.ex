defmodule KrWeb.API.TrickView do
  use KrWeb, :view

  alias KrWeb.API.CardView

  def render_trick(trick) do
    Enum.map(trick, &render_played_card(&1))
  end

  def render_played_card(played_card) do
    played_card
    |> CardView.render_card()
    |> Map.put(:player, played_card.player)
    |> Map.put(:winning, played_card.winning)
  end
end
