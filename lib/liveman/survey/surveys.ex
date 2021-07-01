defmodule Liveman.Survey.Surveys do
  use Ecto.Schema

  alias Liveman.Repo
  alias Liveman.Survey.Schemas.{Survey, Question}

  @survey_json "priv/repo/data/surveys.json"

  def list_surveys do
    json_survey_list = get_json(@survey_json)

    Enum.map(json_survey_list, fn survey ->
      result = %Survey{
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

      Enum.each(survey["questions"], fn question ->
        question = %Question{
          id: question["id"],
          survey_id: survey["id"],
          text: question["text"],
          help_text: question["help_text"],
          display_order: question["display_order"],
          short_text: question["short_text"],
          pick: question["pick"],
          display_type: question["display_type"],
          is_mandatory: question["is_mandatory"],
          correct_answer_id: question["correct_answer_id"],
          facebook_profile: question["facebook_profile"],
          twitter_profile: question["twitter_profile"],
          image_url: question["image_url"],
          cover_image_url: question["cover_image_url"],
          cover_image_opacity: question["cover_image_opacity"],
          cover_background_color: question["cover_background_color"],
          is_shareable_on_facebook: question["is_shareable_on_facebook"],
          is_shareable_on_twitter: question["is_shareable_on_twitter"],
          font_face: question["font_face"],
          font_size: question["font_size"],
          tag_list: question["tag_list"]
        }
      end)

      j = Repo.preload(result, :questions)
      IO.puts("*********************")
      IO.inspect(j, label: "Survey")
      IO.puts("*********************")
      j
    end)
  end

  def get_json(filename) do
    with {:ok, body} <- File.read(filename), {:ok, json} <- Jason.decode!(body), do: {:ok, json}
  end
end
