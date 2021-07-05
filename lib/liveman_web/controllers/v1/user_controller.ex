defmodule LivemanWeb.V1.UserController do
  use LivemanWeb, :controller

  alias LivemanWeb.V1.UserView

  def show(conn, _params) do
    render(conn, UserView, "show.json", %{data: build(:user)})
  end
end
