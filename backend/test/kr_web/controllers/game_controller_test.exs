defmodule KrWeb.API.GameControllerTest do
  use KrWeb.ConnCase

  describe "create" do
    test "creates game when user exists", %{conn: conn} do
      user = insert(:user)
      conn = post(conn, api_game_path(conn, :create), %{user_id: user.id})
      assert body = json_response(conn, 200)
      assert %{
        "talon" => talon,
        "hands" => %{
          "p1" => %{
            "clubs" => p1clubs,
            "hearts" => p1hearts,
            "diamonds" => p1diamonds,
            "spades" => p1spades,
            "trumps" => p1trumps
          },
          "p2" => %{
            "clubs" => p2clubs,
            "hearts" => p2hearts,
            "diamonds" => p2diamonds,
            "spades" => p2spades,
            "trumps" => p2trumps
          },
          "p3" => %{
            "clubs" => p3clubs,
            "hearts" => p3hearts,
            "diamonds" => p3diamonds,
            "spades" => p3spades,
            "trumps" => p3trumps
          },
          "p4" => %{
            "clubs" => p4clubs,
            "hearts" => p4hearts,
            "diamonds" => p4diamonds,
            "spades" => p4spades,
            "trumps" => p4trumps
          }
        },
        "id" => _store_id,
      } = body

      assert length(talon) === 6
      assert length(p1clubs ++ p1hearts ++ p1diamonds ++ p1spades ++ p1trumps) === 12
      assert length(p2clubs ++ p2hearts ++ p2diamonds ++ p2spades ++ p2trumps) === 12
      assert length(p3clubs ++ p3hearts ++ p3diamonds ++ p3spades ++ p3trumps) === 12
      assert length(p4clubs ++ p4hearts ++ p4diamonds ++ p4spades ++ p4trumps) === 12
    end
  end
end
