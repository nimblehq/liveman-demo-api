defmodule LivemanWeb.ApiHelper do
  import Plug.Conn

  def authenticated_api_conn(conn) do
    put_req_header(conn, "access_token", "secret-access-token")
  end
end
