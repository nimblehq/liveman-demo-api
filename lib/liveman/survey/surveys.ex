defmodule Liveman.Survey.Surveys do
  use Ecto.Schema

  alias Liveman.Survey.Schemas.Survey

  @survey_json "priv/repo/data/surveys.json"

  def list_surveys do
    json_survey_list = get_json(@survey_json)

    Enum.map(json_survey_list, fn survey ->
      %Survey{
        id: survey["id"],
        title: survey["title"],
        description: survey["description"],
        thank_email_above_threshold: survey["thank_email_above_threshold"],
        thank_email_below_threshold: survey["thank_email_below_threshold"],
        is_active: survey["is_active"],
        cover_image_url: survey["cover_image_url"],
        created_at: survey["created_at"],
        active_at: survey["active_at"],
        inactive_at: survey["inactive_at"],
        type: survey["type"]
      }
    end)
  end

  def get_json(filename) do
    with {:ok, body} <- File.read(filename), {:ok, json} <- Jason.decode!(body), do: {:ok, json}
  end
end
