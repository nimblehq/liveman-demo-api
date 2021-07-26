defmodule Liveman.User.UsersTest do
  use Liveman.DataCase, async: true

  alias Liveman.User.Users

  describe "validate_registration_params/1" do
    test "returns :ok tuple when the given params are valid" do
      params = %{"email" => "john@doe.com", "password" => "secret"}

      result = Users.validate_registration_params(params)

      assert result == :ok
    end

    test "returns an error when the given email and password params are blank" do
      params = %{"email" => "", "password" => ""}

      result = Users.validate_registration_params(params)

      assert result == {:error, "Email and Password cannot be blank"}
    end

    test "returns an error when given the email param is blank" do
      params = %{"email" => "", "password" => "secret"}

      result = Users.validate_registration_params(params)

      assert result == {:error, "Email cannot be blank"}
    end

    test "returns an error when the given password param is blank" do
      params = %{"email" => "john@doe.com", "password" => ""}

      result = Users.validate_registration_params(params)

      assert result == {:error, "Password cannot be blank"}
    end

    test "returns an error when the given email param is invalid" do
      params = %{"email" => "invalid@email", "password" => "secret"}

      result = Users.validate_registration_params(params)

      assert result == {:error, "Email is invalid"}
    end

    test "returns an error when the given password param is less then 6 charecters" do
      params = %{"email" => "john@doe.com", "password" => "sec"}

      result = Users.validate_registration_params(params)

      assert result == {:error, "Password cannot be less than 6 characters"}
    end

    test "returns an error when the given email and password params are invalid" do
      params = %{"email" => "invalid@email", "password" => "sec"}

      result = Users.validate_registration_params(params)

      assert result == {:error, "Email is invalid and Password cannot be less than 6 characters"}
    end
  end
end
