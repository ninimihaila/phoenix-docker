ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(PhxApp.Repo, :manual)

{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, PhxAppWeb.Endpoint.url())
