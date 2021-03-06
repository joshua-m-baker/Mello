defmodule TrelloWeb.Router do
  use TrelloWeb, :router

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

  scope "/", TrelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index 
    get "/hello/:messenger", HelloController, :show
    resources "/notes", NoteController do
      resources "/cards", CardController
    end
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrelloWeb do
  #   pipe_through :api
  # end
end
