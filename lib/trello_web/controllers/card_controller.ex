defmodule TrelloWeb.CardController do
    use TrelloWeb, :controller

    alias Trello.{Repo, Card, List}

    def index(conn, _params) do
        conn
    end

    def show(conn, %{"id" => card_id}) do
        card = Trello.Repo.get(Trello.Card, card_id)
        changeset = Card.changeset(card, %{})
        render(conn, "card_view.html", changeset: changeset)
    end

    def update(conn, %{"id" => id, "card" => params}) do
        IO.inspect params
        c = Repo.get!(Card, id)
        changeset = Card.changeset(c, params)

        case Repo.update(changeset) do 
            {:ok, c} -> 
                conn 
                |> put_flash(:info, "Card updated successfully") 
                |> redirect(to: Routes.note_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} -> 
                render(conn, "card_view.html", changeset: changeset)
        end
    end

    def new(conn, params) do 
        changeset = List.change_card(%Card{})
        render(conn, "new.html", changeset: changeset, list_id: conn.path_params["note_id"])
    end 

    def create(conn, %{"card" => card_params}) do 
        l = Repo.get(List, 1)
        case Trello.List.create_card(l, card_params) do
            {:ok, card} -> 
                conn 
                |> put_flash(:info, "Card created!") 
                |> redirect(to: Routes.note_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} -> 
                render(conn, "new.html", changeset: changeset)
        end
    end
end