defmodule Liveman.Repo do
  use Ecto.Repo,
    otp_app: :liveman,
    adapter: Ecto.Adapters.Postgres
end
