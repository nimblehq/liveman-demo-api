defmodule LivemanWeb.Plugs.AuthTest do
  use LivemanWeb.ConnCase, async: true

  alias LivemanWeb.Plugs.Auth

  test "returns an authenticated connection when the request is an authenticated request", %{
    conn: conn
  } do
    conn = conn |> authenticated_api_conn |> Auth.authenticate_user(%{})
    access_token = conn |> get_req_header("access_token") |> Enum.at(0)

    assert access_token
  end

  test "returns an error response when the request is an unauthenticated request", %{conn: conn} do
    conn = Auth.authenticate_user(conn, %{})

    assert json_response(conn, 401) == %{
             "errors" => [%{"detail" => "Authentication failed"}]
           }
  end
end
