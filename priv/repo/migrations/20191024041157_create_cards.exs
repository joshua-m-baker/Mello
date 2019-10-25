defmodule Trello.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string
      add :description, :string
      add :list_id, references(:lists)
      timestamps()
    end

  end
end
