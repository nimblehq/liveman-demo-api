defmodule LivemanWeb.V1.AnswerController do
  use LivemanWeb, :controller

  alias Liveman.Survey.Surveys
  alias LivemanWeb.V1.ErrorView

  def create(conn, params) do
    case Surveys.create_answers(params) do
      :ok ->
        send_resp(conn, :created, "")

      {:error, :invalid_survey} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: "Survey is invalid"}])

      {:error, :invalid_questions} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: [%{detail: "Questions are invalid"}])
    end
  end
end
