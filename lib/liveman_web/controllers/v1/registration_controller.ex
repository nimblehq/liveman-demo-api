defmodule LivemanWeb.V1.RegistrationController do
  use LivemanWeb, :controller
  use Parameters

  alias LivemanWeb.V1.ErrorView

  params do
    requires(:email, :string)
  end

  def create(conn, params) do
    email = params["email"] || ""
    password = params["password"] || ""

    case validate_params(email, password) do
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

  def validate_params(email, password) when email == "" and password == "" do
    {:error, :empty_email_and_password}
  end

  def validate_params(email, password) when email == "" and password != "" do
    {:error, :empty_email}
  end

  def validate_params(email, password) when email != "" and password == "" do
    {:error, :empty_password}
  end

  def validate_params(_, _), do: :ok
end
