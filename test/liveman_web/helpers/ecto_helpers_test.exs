defmodule LivemanWeb.EctoHelpersTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Schemas.User
  alias LivemanWeb.EctoHelpers

  describe "pretty_errors/1" do
    test "returns correct error messages when the email and password params are blank" do
      invalid_params = %{email: "", password: ""}
      changeset = User.changeset(invalid_params)

      assert EctoHelpers.pretty_errors(changeset.errors) == [
               "Password can't be blank",
               "Email can't be blank"
             ]
    end
  end

  test "returns correct error messages when the email param is invalid" do
    invalid_params = %{email: "invalid-email", password: "secret"}
    changeset = User.changeset(invalid_params)

    assert EctoHelpers.pretty_errors(changeset.errors) == [
             "Email is invalid"
           ]
  end

  test "returns correct error messages when the password param is invalid" do
    invalid_params = %{email: "john@doe.com", password: "abc"}
    changeset = User.changeset(invalid_params)

    assert EctoHelpers.pretty_errors(changeset.errors) == [
             "Password should be at least 6 character(s)"
           ]
  end
end
