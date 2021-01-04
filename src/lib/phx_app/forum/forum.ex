defmodule PhxApp.Forum.Forum do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forums" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(forum, attrs) do
    forum
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
