defmodule KrWeb.API.ResponseControllerTest do

  use KrWeb.ConnCase
  alias Kr.{Cards, Games, Hands, Settings, Store, Stores}

  setup do
    user = insert(:user)
    %Store{id: store_id} = Stores.create_store!(%{user_id: user.id})
    pid = Settings.start_link(store_id)
    Games.init_game!(pid)
    {:ok, pid: pid, store_id: store_id}
  end

  describe "create" do
    test "applies response", %{conn: conn, pid: pid, store_id: store_id} do
      hand = Hands.build_hand([Cards.get_card(:diamond_7)])
      Hands.set_hand!(pid, :p1, hand)

      Process.sleep(200)

      conn = post(conn, api_response_path(conn, :create), %{card_slug: "diamond_7", player: "p1", game_id: store_id})
      assert body = json_response(conn, 200)

      returned_diamonds =
        body
        |> Map.get("game")
        |> Map.get("hands")
        |> Map.get("p1")
        |> Map.get("diamonds")

      assert returned_diamonds === []

      returned_current_trick =
        body
        |> Map.get("game")
        |> Map.get("trick")
        |> Map.get("p1")

      assert %{"slug" => "diamond_7"} = returned_current_trick
    end
  end
end
