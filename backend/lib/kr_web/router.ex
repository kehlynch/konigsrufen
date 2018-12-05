defmodule KrWeb.Router do
  use KrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KrWeb.API, as: :api do
    pipe_through :api

    # resources "/hands", GamesController, only: [:create]
    resources "/responses", ResponseController, only: [:create]
    resources "/games", GameController, only: [:create, :show]

    get "/usergames/:user_id", GameController, :index

    get "/users/:email", UserController, :show_or_create
  end
end
