defmodule KrWeb.API.TrickView do
  use KrWeb, :view

  alias KrWeb.API.CardView

  def render_trick(%{} = trick) do
    Map.new()
    |> Map.put(:p1, CardView.render_card(trick.p1))
    |> Map.put(:p2, CardView.render_card(trick.p2))
    |> Map.put(:p3, CardView.render_card(trick.p3))
    |> Map.put(:p4, CardView.render_card(trick.p4))
  end
end
