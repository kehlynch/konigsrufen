defmodule KrWeb.API.UserController do
  use KrWeb, :controller

  alias Kr.Users

  def show_or_create(conn, %{"email" => email}) do
    user = Users.get_or_create_user!(%{email_address: email})
    render(conn, "show.json", user: user)
  end
end
