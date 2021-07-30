defmodule Liveman.Repo.Migrations.CraeteUsersTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :email, :citext, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
