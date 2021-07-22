defmodule Liveman.User.Users do
  def validate_registratiom_params(params) do
    email = params["email"] || ""
    password = params["password"] || ""
    validate_credential_params(email, password)
  end

  defp validate_credential_params(email, password) when email == "" and password == "" do
    {:error, :empty_email_and_password}
  end

  defp validate_credential_params(email, password) when email == "" and password != "" do
    {:error, :empty_email}
  end

  defp validate_credential_params(email, password) when email != "" and password == "" do
    {:error, :empty_password}
  end

  defp validate_credential_params(_, _), do: :ok
end
