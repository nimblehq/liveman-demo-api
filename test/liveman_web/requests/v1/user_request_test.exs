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

  describe "POST /v1/users/signup" do
    test "returns a success response when the request params are valid", %{conn: conn} do
      params = %{"email" => "john@doe.com", "password" => "secret"}

      conn =
        conn
        |> authenticated_api_conn
        |> post(Routes.api_v1_user_path(conn, :create, params))

      assert json_response(conn, 200) == %{
               "meta" => %{"detail" => "An confirmation email has been sent with an OTP code"}
             }
    end

    test "returns an error response when the request params are invalid", %{conn: conn} do
      params = %{"email" => "", "password" => ""}

      conn =
        conn
        |> authenticated_api_conn
        |> post(Routes.api_v1_user_path(conn, :create, params))

      assert json_response(conn, 422) == %{
               "errors" => [%{"detail" => "Email and Password cannot be blank"}]
             }
    end
  end

  describe "POST /v1/users/verify" do
    test "returns the user data when the request params are valid", %{conn: conn} do
      params = %{"otp" => "secret"}

      conn =
        conn
        |> authenticated_api_conn
        |> post(Routes.api_v1_user_path(conn, :verify, params))

      assert %{
               "data" => %{
                 "attributes" => %{
                   "avatar_url" => _,
                   "email" => _
                 },
                 "id" => _,
                 "relationships" => %{},
                 "type" => "user"
               },
               "included" => []
             } = json_response(conn, 200)
    end

    test "returns an error response when the request params are invalid", %{conn: conn} do
      params = %{"otp" => ""}

      conn =
        conn
        |> authenticated_api_conn
        |> post(Routes.api_v1_user_path(conn, :verify, params))

      assert json_response(conn, 422) == %{"errors" => [%{"detail" => "OTP cannot be blank"}]}
    end
  end
end
