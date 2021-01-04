defmodule PhxAppWeb.ForumController do
  use PhxAppWeb, :controller

  def index(conn, _params) do
    forums = PhxApp.Forum.all_forums()

    render(conn, "index.html", forums: forums)
  end
end