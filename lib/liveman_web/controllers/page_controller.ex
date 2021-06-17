defmodule LivemanWeb.PageController do
  use LivemanWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
