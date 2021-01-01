defmodule PhxAppWeb.UserVisitsHomepageTest do
  use PhxAppWeb.FeatureCase, async: true

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".phx-hero", text: "Welcome to Phoenix!"))
  end
end
