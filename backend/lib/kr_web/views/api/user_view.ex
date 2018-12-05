defmodule KrWeb.API.UserView do
  use KrWeb, :view

  alias Kr.User

  def render("show.json", %{user: %User{} = user}) do
    Map.new()
    |> Map.put(:id, user.id)
  end
end
