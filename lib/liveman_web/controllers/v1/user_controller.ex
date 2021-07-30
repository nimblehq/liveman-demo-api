defmodule LivemanWeb.V1.UserController do
  use LivemanWeb, :controller

  import LivemanWeb.EctoHelpers

  alias Liveman.User.Users
  alias LivemanWeb.V1.ErrorView
  alias LivemanWeb.V1.UserView

  def create(conn, params) do
    case Users.register_user(params) do
      {:ok, _} ->
        json(conn, %{meta: %{detail: "An confirmation email has been sent with an OTP code"}})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: error_message(changeset.errors)}])
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

  defp error_message(errors) do
    Enum.join(pretty_errors(errors), ", ")
  end
end
