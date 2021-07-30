defmodule LivemanWeb.EctoHelpersTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Schemas.User
  alias Liveman.User.Users
  alias LivemanWeb.EctoHelpers

  describe "pretty_errors/1" do
    test "returns formatted error messages when the email and password params are blank" do
      invalid_params = %{email: "", password: ""}
      changeset = User.changeset(invalid_params)

      assert EctoHelpers.pretty_errors(changeset.errors) == [
               "Password can't be blank",
               "Email can't be blank"
             ]
    end

    test "returns formatted error messages when the email param is invalid" do
      invalid_params = %{email: "invalid-email", password: "secret"}
      changeset = User.changeset(invalid_params)

      assert EctoHelpers.pretty_errors(changeset.errors) == [
               "Email is invalid"
             ]
    end

    test "returns formatted error messages when the password param is invalid" do
      invalid_params = %{email: "john@doe.com", password: "abc"}
      changeset = User.changeset(invalid_params)

      assert EctoHelpers.pretty_errors(changeset.errors) == [
               "Password should be at least 6 character(s)"
             ]
    end

    test "returns formatted error messages when the email param is not unique" do
      email = "john@doe.com"
      insert(:user, email: email)
      {:error, changeset} = Users.register_user(%{email: email, password: "secret"})

      assert EctoHelpers.pretty_errors(changeset.errors) == [
               "Email has already been taken"
             ]
    end
  end
end
