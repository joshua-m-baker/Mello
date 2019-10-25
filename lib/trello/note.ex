defmodule Trello.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_notes" do
    field :name, :string
    field :note, :string
    field :rank, :integer

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:name, :note, :rank])
    |> validate_required([:name, :note, :rank])
  end
end
