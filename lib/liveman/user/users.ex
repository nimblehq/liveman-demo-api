defmodule Liveman.User.Users do
  @email_regex_format ~r/^\S+@\S+\.\S+$/

  def validate_registration_params(params) do
    email = params["email"] |> to_string() |> String.trim()
    password = params["password"] |> to_string() |> String.trim()

    validate_credential_params_presence(email, password)
  end

  defp validate_credential_params_presence(email, password) when email == "" and password == "" do
    {:error, "Email and Password cannot be blank"}
  end

  defp validate_credential_params_presence(email, password) when email == "" and password != "" do
    {:error, "Email cannot be blank"}
  end

  defp validate_credential_params_presence(email, password) when email != "" and password == "" do
    {:error, "Password cannot be blank"}
  end

  defp validate_credential_params_presence(email, password) do
    cond do
      !valid_email?(email) && !valid_password?(password) ->
        {:error, "Email is invalid and Password cannot be less than 6 characters"}

      !valid_email?(email) && valid_password?(password) ->
        {:error, "Email is invalid"}

      valid_email?(email) && !valid_password?(password) ->
        {:error, "Password cannot be less than 6 characters"}

      true ->
        :ok
    end
  end

  defp valid_email?(email) do
    Regex.match?(@email_regex_format, email)
  end

  defp valid_password?(password) do
    String.length(password) >= 6
  end
end
