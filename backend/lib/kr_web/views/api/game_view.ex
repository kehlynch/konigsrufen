defmodule KrWeb.API.GameView do
  use KrWeb, :view

  alias KrWeb.API.{CardView, HandView, TrickView}

  def render("show.json", %{game: game, store_id: store_id}) do
    render_game(game, store_id)
  end

  def render_game(game, store_id) do
    Map.new()
    |> Map.put(:hands, HandView.render_hands(game.hands))
    |> Map.put(:trick, render_current_trick(game))
    |> Map.put(:talon, CardView.render_cards(game.talon))
    |> Map.put(:id, store_id)
  end

  def render_current_trick(%{current_trick: trick}) do
    TrickView.render_trick(trick)
  end

  def render_current_trick(_), do: %{}
end
