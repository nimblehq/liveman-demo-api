defmodule Liveman.User.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  @email_regex_format ~r/^\S+@\S+\.\S+$/

  @derive {Inspect, except: [:password]}
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:hashed_password, :string)

    timestamps()
  end

  def changeset(individual \\ %__MODULE__{}, attrs) do
    individual
    |> cast(attrs, [:email, :password])
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, @email_regex_format, message: "is invalid")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 80)
    |> update_hashed_password
  end

  defp update_hashed_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      changeset
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end
end
