defmodule KrWeb.API.DefaultView do
  use KrWeb, :view

  def render("status.json", %{status_code: status_code}) do
    %{message: to_string(status_code)}
  end
end
