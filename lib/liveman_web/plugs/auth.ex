defmodule LivemanWeb.Plugs.Auth do
  use LivemanWeb, :controller

  import Plug.Conn

  alias LivemanWeb.V1.ErrorView

  def init(opts), do: opts

  def call(conn, _) do
    authenticate_user(conn)
  end

  defp authenticate_user(conn) do
    access_token =
      conn
      |> get_req_header("access_token")
      |> Enum.at(0)

    # If no access_token header key, then access_token value is nil.
    # If access_token header key is present, but value is empty
    # then access_token value is empty string
    if access_token == nil || String.trim(access_token) == "" do
      conn
      |> put_status(:unauthorized)
      |> render(ErrorView, "error.json", errors: [%{detail: "Authentication failed"}])
      |> halt()
    else
      conn
    end
  end
end
