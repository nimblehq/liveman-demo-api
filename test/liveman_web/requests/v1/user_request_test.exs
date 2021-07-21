defmodule LivemanWeb.V1UserRequestTest do
  use LivemanWeb.ConnCase, async: true

  describe "GET /v1/me" do
    test "returns 200 status when request successfully", %{conn: conn} do
      conn =
        conn
        |> authenticated_api_conn
        |> get(Routes.api_v1_user_path(conn, :show))

      assert conn.status == 200
    end

    test "returns an error response when the request is an unauthenticated request", %{
      conn: conn
    } do
      conn = get(conn, Routes.api_v1_user_path(conn, :show))

      assert json_response(conn, 401) == %{
               "errors" => [%{"detail" => "Authentication failed"}]
             }
    end
  end
end
