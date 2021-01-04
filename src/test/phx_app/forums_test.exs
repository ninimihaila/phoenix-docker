defmodule PhxApp.ForumsTest do
  #  performs a lot of setup that is useful when interacting with the
  # database, such as importing Ecto functions, aliasing our Repo,
  # and checking out a connection from Ecto's SQL sandbox.
  use PhxApp.DataCase, async: true

  import PhxApp.Factory

  alias PhxApp.Forum

  describe "all_rooms/0" do
    test "returns all forums available" do
      [forum1, forum2] = insert_pair(:forum)

      forums = Forum.all_forums()

      assert forum1 in forums
      assert forum2 in forums
    end
  end
end