defmodule KrWeb.API.ResponseControllerTest do

  use KrWeb.ConnCase
  alias Kr.{Games, Hands, Settings, Store, Stores}

  setup do
    user = insert(:user)
    %Store{id: store_id} = Stores.create_store!(%{user_id: user.id})
    pid = Settings.start_link(store_id)
    Games.init_game!(pid)
    {:ok, pid: pid, store_id: store_id}
  end

  describe "create" do
    test "applies response", %{conn: conn, pid: pid, store_id: store_id} do
      card_slug =
        pid
        |> Hands.get_hand(:p1)
        |> Map.values()
        |> List.flatten()
        |> Enum.random()
        |> Map.get(:slug)

      conn = post(conn, api_response_path(conn, :create), %{card_slug: card_slug, player: "p1", game_id: store_id})
      assert body = json_response(conn, 200)

      returned_trick =
        body
        |> Map.get("game")
        |> Map.get("tricks")
        |> Enum.at(0)
        |> Enum.find(fn played_card ->
          Map.get(played_card, "player") === "p1"
        end)

      slug_string = Atom.to_string(card_slug)
      assert %{"slug" => ^slug_string} = returned_trick
    end
  end
end
