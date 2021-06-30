defmodule LivemanWeb.V1.SurveyController do
  use LivemanWeb, :controller

  alias LivemanWeb.V1.SurveyView

  def index(conn, _params) do
    render(conn, SurveyView, "index.json", %{data: build(:survey)})
  end
end
