defmodule LivemanWeb.V1.RegistrationController do
  use LivemanWeb, :controller

  alias LivemanWeb.V1.ErrorView
  alias Liveman.User.Users

  def create(conn, params) do
    case Users.validate_registratiom_params(params) do
      :ok ->
        json(conn, %{meta: %{detail: "An confirmation email has been sent with OTP code"}})

      {:error, :empty_email} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: "Email cannot be blank"}])

      {:error, :empty_password} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: "Password cannot be blank"}])

      {:error, :empty_email_and_password} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: "Email and Password cannot be blank"}])
    end
  end
end
