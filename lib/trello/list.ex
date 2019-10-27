defmodule Trello.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias Trello.{Repo, Card, List}

  schema "lists" do
    field :name, :string
    has_many :cards, Trello.Card, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @doc false
  def change_card(%Card{} = card) do
    Card.changeset(card, %{})
  end

  def create_card(%List{} = list, attrs \\ %{}) do 
    %Card{} 
    |> Card.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:list, list)
    |> Repo.insert()
  end 
end
