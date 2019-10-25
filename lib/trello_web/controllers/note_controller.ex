defmodule TrelloWeb.NoteController do
    use TrelloWeb, :controller
    alias Trello.Repo

    def index(conn, _params) do
        #query = from l in Trello.List, preload: [:cards] 
        #list_data = Trello.Repo.all(Trello.List)
        #list_card = Trello.Repo.preload(list_data, :cards)
        list_card = Repo.all(Trello.List) |> Repo.preload(:cards)

        #note_data = Trello.Repo.all(Trello.Note)
        render(conn, "index.html", list_data: list_card)
    end
  end