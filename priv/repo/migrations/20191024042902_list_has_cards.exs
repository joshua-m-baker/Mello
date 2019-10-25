defmodule Trello.Repo.Migrations.ListHasCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :list_id, references(:lists)
    end
  end
end
