defmodule TrelloWeb.CardController do
    use TrelloWeb, :controller

    alias Trello.{Repo, Card, List}

    def index(conn, _params) do
        conn
    end

    def show(conn, %{"id" => card_id}) do
        card = Trello.Repo.get(Trello.Card, card_id)
        render(conn, "card_view.html", card: card)
    end

    def edit(conn, %{"card_name" => name, "card_description" => description, "id" => card_id}) do
        
        c = Repo.get!(Card, card_id)
        cs = Card.changeset(c, %{name: name, description: description})

        case Repo.update(cs) do 
            {:ok, c} -> 
                IO.puts "Updated"
            {:error, cs} -> 
                IO.puts "Failed"
        end
        redirect(conn, to: "/notes")
    end

    def new(conn, params) do 
        changeset = List.change_card(%Card{})
        render(conn, "new.html", changeset: changeset)
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