defmodule LivemanWeb.Plug.Auth do
  use LivemanWeb, :controller

  import Plug.Conn

  alias LivemanWeb.V1.ErrorView

  def authenticate_user(conn, _) do
    access_token =
      conn
      |> get_req_header("access_token")
      |> Enum.at(0)

    # If no access_token header key, then access_token value is nil
    # If access_token header key is present, but value is empty then access_token length is zero
    if access_token == nil || String.length(String.trim(access_token)) == 0 do
      conn
      |> put_status(:unauthorized)
      |> render(ErrorView, "error.json", errors: [%{detail: "Authentication failed"}])
      |> halt()
    else
      conn
    end
  end
end
