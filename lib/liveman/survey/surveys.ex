defmodule Liveman.Survey.Surveys do
  use Ecto.Schema

  alias Liveman.Survey.Schemas.Survey

  @json_file "priv/repo/data/surveys.json"

  def list_surveys do
    survey_list_json = fetch_surveys_from_file!()

    get_survey_list(survey_list_json)
  end

  def fetch_surveys_from_file! do
    file_path = "#{File.cwd!()}/#{@json_file}"
    {_, body} = File.read(file_path)
    IO.puts("***************")
    IO.inspect(file_path, label: "file_path: ")
    IO.inspect(body, label: "Body is: ")
    IO.puts("***************")
    # Jason.decode!(body)
  end

  def create_answers(params) do
    survey = get_survey(params["survey_id"])

    validate(survey, params["questions"])
  end

  defp validate(nil, _questions), do: {:error, :invalid_survey}
  defp validate(_survey, nil), do: {:error, :invalid_questions}

  defp validate(survey, questions) do
    survey_questions_ids = get_survey_question_ids(survey.questions)
    question_ids = get_question_ids(questions)

    # Check if all submitted questions are belong to the survey
    if question_ids -- survey_questions_ids == [] do
      :ok
    else
      {:error, :invalid_questions}
    end
  end

  defp get_survey_list(survey_list_json) do
    Enum.map(survey_list_json, &build_survey/1)
  end

  defp build_survey(json) do
    %Survey{}
    |> Survey.changeset(json)
    |> Ecto.Changeset.apply_changes()
  end

  defp get_survey(survey_id) do
    Enum.find(list_surveys(), fn survey -> survey_id == survey.id end)
  end

  defp get_question_ids(questions) do
    Enum.map(questions, fn question -> question["id"] end)
  end

  defp get_survey_question_ids(survey_questions) do
    Enum.map(survey_questions, fn question -> question.id end)
  end
end
