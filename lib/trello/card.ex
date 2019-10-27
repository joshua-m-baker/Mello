defmodule Trello.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :description, :string
    field :name, :string
    belongs_to :list, Trello.List
    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

end
