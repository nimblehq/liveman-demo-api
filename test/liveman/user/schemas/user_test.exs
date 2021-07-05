defmodule Liveman.User.Schemas.UserTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Schemas.User

  describe "changeset/2" do
    test "returns valid changeset given valid params" do
      params = params_for(:user)

      changeset = User.changeset(params)

      assert changeset.valid?
      assert changeset.changes == params
    end

    test "returns invalid changeset if params are missing" do
      changeset = User.changeset(%{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               email: ["can't be blank"]
             }
    end

    test "returns invalid changeset if params are empty" do
      attrs = %{email: ""}

      changeset = User.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               email: ["can't be blank"]
             }
    end
  end
end
