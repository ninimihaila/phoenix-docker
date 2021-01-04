defmodule PhxApp.Repo.Migrations.CreateForums do
  use Ecto.Migration

  def change do
    create table(:forums) do
      add :name, :string

      timestamps()
    end

    create unique_index(:forums, [:name])
  end
end
