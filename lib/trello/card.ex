defmodule Trello.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :description, :string
    field :name, :string
    belongs_to :list, Trello.List, [on_replace: :update]
    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:name, :description, :list_id])
    |> validate_required([:name, :description])
    |> cast_assoc(:list)
  end
end
