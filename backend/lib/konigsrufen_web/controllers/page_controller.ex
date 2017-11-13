defmodule KonigsrufenWeb.PageController do
  use KonigsrufenWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
