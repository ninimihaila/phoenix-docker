defmodule PhxAppWeb.UserVisitsForumsPageTest do
  use PhxAppWeb.FeatureCase, async: true

  test "user can visit forum page", %{session: session} do
    session
    |> visit("/forum")
    |> assert_has(Query.css(".title", text: "Welcome to Forum!"))
  end

  test "user visits forums page to see a list of forums", %{session: session} do
    [forum1, forum2] = insert_pair(:forum)

    session
    |> visit(forums_index())
    |> assert_has(forum_name(forum1.name))
    |> assert_has(forum_name(forum2.name))
  end

  defp forums_index, do: Routes.forum_path(@endpoint, :index)

  defp forum_name(name) do
    Query.data("role", "forum", text: name)
  end
end