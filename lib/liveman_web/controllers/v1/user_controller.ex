defmodule LivemanWeb.V1.UserController do
  use LivemanWeb, :controller

  alias LivemanWeb.V1.UserView
  alias LivemanWeb.V1.ErrorView
  alias Liveman.User.Users

  def create(conn, params) do
    case Users.validate_registratiom_params(params) do
      :ok ->
        json(conn, %{meta: %{detail: "An confirmation email has been sent with OTP code"}})

      {:error, message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: message}])
    end
  end

  def verify(conn, params) do
    otp = params["otp"] |> to_string() |> String.trim()

    if otp != "" do
      render(conn, UserView, "show.json", %{data: build(:user)})
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ErrorView, "error.json", errors: [%{detail: "OTP cannot be blank"}])
    end
  end

  def show(conn, _params) do
    render(conn, UserView, "show.json", %{data: build(:user)})
  end
end
