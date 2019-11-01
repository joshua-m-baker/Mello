#TODO: new cards not saving to list 2
defmodule Trello.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias Trello.{Repo, Card, List}

  schema "lists" do
    field :name, :string
    has_many :cards, Trello.Card, on_delete: :delete_all
    timestamps()
  end

  def get_all_lists() do
    Repo.all(List)
  end

  def get_lists_enum() do
    Repo.all(List) |> Enum.map(&{&1.name, &1.id})
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name]) 
  end

  def new_list(%List{} = list) do
    List.changeset(list, %{})
  end

  def create_list(attrs \\ %{}) do 
    %List{} 
    |> List.changeset(attrs)
    |> Repo.insert()
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

  def move_card(card_changeset, list_id) do
    IO.inspect list_id
    l = Repo.get(List, list_id)
    card_changeset |>
    Ecto.Changeset.put_assoc(:list, l)
  end
end
