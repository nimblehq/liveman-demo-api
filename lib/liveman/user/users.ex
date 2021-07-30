defmodule Liveman.User.Users do
  import Ecto.Query, warn: false

  alias Liveman.Repo
  alias Liveman.User.Schemas.User

  def register_user(user_params) do
    %User{} |> User.changeset(user_params) |> Repo.insert()
  end
end
