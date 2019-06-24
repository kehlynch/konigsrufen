defmodule KrWeb.API.GameView do
  use KrWeb, :view

  alias KrWeb.API.{CardView, HandView, TrickView}

  def render("show.json", %{game: game, store_id: store_id}) do
    render_game(game, store_id)
  end

  def render_game(game, store_id) do
    Map.new()
    |> Map.put(:hands, HandView.render_hands(game.hands))
    |> Map.put(:tricks, render_tricks(game))
    |> Map.put(:talon, CardView.render_cards(game.talon))
    |> Map.put(:id, store_id)
    |> Map.put(:finished, Map.get(game, :finished, false))
    |> Map.put(:scoresList, Map.get(game, :scores))
    |> Map.put(:points, Map.get(game, :points))
  end

  def render_tricks(%{tricks: []}), do: [[]]

  def render_tricks(%{tricks: tricks}) do
    tricks
    |> Enum.map(&TrickView.render_trick(&1))
  end
end
