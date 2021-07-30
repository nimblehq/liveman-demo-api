defmodule LivemanWeb.EctoHelpersTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Schemas.User
  alias LivemanWeb.EctoHelpers

  describe "pretty_errors/1" do
    test "returns the errors messages in an list" do
      invalid_params = %{email: "", password: ""}
      changeset = User.changeset(invalid_params)

      assert EctoHelpers.pretty_errors(changeset.errors) == [
               "Password can't be blank",
               "Email can't be blank"
             ]
    end
  end
end
