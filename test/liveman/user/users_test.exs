defmodule Liveman.User.UsersTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Users

  describe "register_user/1" do
    test "requires email and password to be set" do
      {:error, changeset} = Users.register_user(%{})

      assert %{
               password: ["can't be blank"],
               email: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "validates email and password when given" do
      {:error, changeset} = Users.register_user(%{email: "not valid", password: "abc"})

      assert %{
               email: ["is invalid"],
               password: ["should be at least 6 character(s)"]
             } == errors_on(changeset)
    end

    test "validates email uniqueness" do
      email = "john@doe.com"
      insert(:user, email: email)
      {:error, changeset} = Users.register_user(%{email: email, password: "secret"})

      assert "has already been taken" in errors_on(changeset).email
    end
  end
end
