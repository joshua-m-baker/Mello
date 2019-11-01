defmodule TrelloWeb.NoteController do
    use TrelloWeb, :controller

    def index(conn, _params) do
        #query = from l in Trello.List, preload: [:cards] 
        #list_data = Trello.Repo.all(Trello.List)
        #list_card = Trello.Repo.preload(list_data, :cards)
        list_card = Trello.Repo.all(Trello.List) |> Trello.Repo.preload(:cards)

        #note_data = Trello.Repo.all(Trello.Note)
        render(conn, "index.html", list_data: list_card)
    end

    def new(conn, params) do 
        changeset = Trello.List.new_list(%Trello.List{})
        render(conn, "new.html", changeset: changeset)
    end 

    def create(conn, %{"list" => list_params}) do 
        case Trello.List.create_list(list_params) do
            {:ok, list} -> 
                conn 
                |> put_flash(:info, "List created!") 
                |> redirect(to: Routes.note_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} -> 
                render(conn, "new.html", changeset: changeset)
        end
    end
end