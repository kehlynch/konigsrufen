defmodule KrWeb.API.ResponseView do
  use KrWeb, :view

  alias KrWeb.API.GameView

  def render("response.json", %{message: message, game: game, store_id: store_id}) do
    Map.new()
    |> Map.put(:message, message)
    |> Map.put(:game, GameView.render_game(game, store_id))
  end
end
