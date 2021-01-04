defmodule PhxApp.Forum do
  alias PhxApp.{Forum, Repo}

  def all_forums do
    Forum.Forum |> Repo.all()
  end
end