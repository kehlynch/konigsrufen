defmodule KrWeb.API.ResponseController do
  use KrWeb, :controller
  import Kr.Helpers
  alias Kr.{Games, Settings}
  action_fallback KrWeb.API.FallbackController

  @spec create(term(), map()) :: no_return()
  def create(conn, %{"game_id" => store_id, "player" => player, "card_slug" => card_slug}) do
    pid = Settings.start_link(store_id)
    message = Games.apply_card_played!(pid, atomise(player), atomise(card_slug))
    # Games.advance_game!(pid)
    game = Games.get_game(pid)
    render(conn, "response.json", message: message, game: game, store_id: store_id)
  end
end
