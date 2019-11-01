defmodule TrelloWeb.CardController do
    use TrelloWeb, :controller

    alias Trello.{Repo, Card, List}

    def index(conn, _params) do
        conn
    end

    def show(conn, %{"id" => card_id}) do
        card = Trello.Repo.get(Trello.Card, card_id) |> Repo.preload(:list)
        changeset = Card.changeset(card, %{})
        render(conn, "card_view.html", changeset: changeset, lists: List.get_lists_enum())
    end

    def update(conn, %{"id" => id, "card" => params, "note_id" => list_id}) do
        c = Repo.get!(Card, id) |> Repo.preload(:list)
        changeset = Card.changeset(c, params) 
        IO.inspect changeset
        case Repo.update(changeset) do 
            {:ok, c} -> 
                conn 
                |> put_flash(:info, "Card updated successfully")
                |> redirect(to: Routes.note_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} ->         
                list_names = for l <- List.get_all_lists(), do: l.name
                render(conn, "card_view.html", changeset: changeset, lists: list_names)
        end
    end

    def new(conn, params) do 
        changeset = List.change_card(%Card{})
        render(conn, "new.html", changeset: changeset, list_id: conn.path_params["note_id"])
    end 

    def create(conn, %{"card" => card_params, "note_id" => list_id}) do 
        l = Repo.get(List, list_id)
        case Trello.List.create_card(l, card_params) do
            {:ok, card} -> 
                conn 
                |> put_flash(:info, "Card created!") 
                |> redirect(to: Routes.note_path(conn, :index))
            {:error, %Ecto.Changeset{} = changeset} -> 
                render(conn, "new.html", changeset: changeset, list_id: list_id)
        end
    end

    def delete(conn, %{"id" => id}) do
        c = Repo.get(Card, id)
        Repo.delete(c) 

        conn 
        |> put_flash(:info, "Card deleted!") 
        |> redirect(to: Routes.note_path(conn, :index))
    
    end
end