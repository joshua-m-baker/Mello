defmodule Trello.Repo.Migrations.CreateUserNotes do
  use Ecto.Migration

  def change do
    create table(:user_notes) do
      add :name, :string
      add :note, :string
      add :rank, :integer

      timestamps()
    end

  end
end
