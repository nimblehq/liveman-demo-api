defmodule LivemanWeb.V1.SurveyView do
  use JSONAPI.View, type: "survey"

  def fields do
    [
      :id,
      :title,
      :description,
      :type,
      :thank_email_above_threshold,
      :thank_email_below_threshold,
      :is_active,
      :cover_image_url,
      :created_at,
      :active_at,
      :inactive_at
    ]
  end

  def relationships do
    [questions: LivemanWeb.V1.QuestionView]
  end
end
