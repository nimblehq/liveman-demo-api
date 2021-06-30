defmodule LivemanWeb.V1UserRequestTest do
  use LivemanWeb.ConnCase, async: true

  describe "GET /v1/me" do
    test "returns 200 status when request successfully", %{conn: conn} do
      conn = get(conn, Routes.api_v1_user_path(conn, :show))

      assert conn.status == 200
    end
  end
end
