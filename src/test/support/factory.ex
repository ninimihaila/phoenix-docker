defmodule PhxApp.Factory do
  use ExMachina.Ecto, repo: PhxApp.Repo

  def forum_factory do
    %PhxApp.Forum.Forum{
      name: sequence(:name, &"Forum #{&1}}")
    }
  end
end