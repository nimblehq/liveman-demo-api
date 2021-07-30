defmodule Liveman.User.UsersTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Users

  describe "register_user/1" do
    test "creates a user successfully when the given params are valid" do
      user = Users.register_user(%{email: "john@doe.com", password: "secret"})

      assert {:ok, _} = user
    end

    test "returns an error when the given params are invalid" do
      {:error, changeset} = Users.register_user(%{})

      assert %{
               password: ["can't be blank"],
               email: ["can't be blank"]
             } = errors_on(changeset)
    end
  end
end
