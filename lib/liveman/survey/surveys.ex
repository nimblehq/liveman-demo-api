defmodule Liveman.Survey.Surveys do
  use Ecto.Schema

  alias Liveman.Survey.Schemas.Survey

  @json_file "priv/repo/data/surveys.json"

  def list_surveys do
    survey_list_json = fecth_surveys_from_file!()

    Enum.map(survey_list_json, fn survey_json ->
      build_survey(survey_json)
    end)
  end

  defp fecth_surveys_from_file! do
    {_, body} = File.read(@json_file)
    Jason.decode!(body)
  end

  defp build_survey(json) do
    %Survey{}
    |> Survey.changeset(json)
    |> Ecto.Changeset.apply_changes()
  end
end
