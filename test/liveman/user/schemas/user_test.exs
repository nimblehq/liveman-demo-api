defmodule Liveman.User.Schemas.UserTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Schemas.User

  describe "changeset/2" do
    test "returns valid changeset given valid params" do
      params = params_for(:user)

      changeset = User.changeset(params)

      assert changeset.valid?

      assert %{
               email: _,
               hashed_password: _
             } = changeset.changes
    end

    test "returns invalid changeset if params are missing" do
      changeset = User.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               email: ["can't be blank"],
               password: ["can't be blank"]
             }
    end

    test "returns invalid changeset if params are empty" do
      attrs = %{email: "", password: ""}

      changeset = User.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               email: ["can't be blank"],
               password: ["can't be blank"]
             }
    end
  end
end
