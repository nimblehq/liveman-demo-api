defmodule LivemanWeb.V1.SurveyController do
  use LivemanWeb, :controller

  alias LivemanWeb.V1.SurveyView
  alias Liveman.Survey.Surveys

  def index(conn, _params) do
    render(conn, SurveyView, "index.json", %{data: Surveys.list_surveys()})
  end
end
