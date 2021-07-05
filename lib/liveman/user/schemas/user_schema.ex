defmodule Liveman.User.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field(:email, :string)

    timestamps()
  end

  def changeset(individual \\ %__MODULE__{}, attrs) do
    individual
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
