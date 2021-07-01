defmodule LivemanWeb.V1.QuestionView do
  use JSONAPI.View, type: "question"

  def fields do
    [
      :text,
      :help_text,
      :display_order,
      :short_text,
      :pick,
      :display_type,
      :is_mandatory,
      :correct_answer_id,
      :facebook_profile,
      :twitter_profile,
      :image_url,
      :cover_image_url,
      :cover_image_opacity,
      :cover_background_color,
      :is_shareable_on_facebook,
      :is_shareable_on_twitter,
      :font_face,
      :font_size,
      :tag_list
    ]
  end
end
