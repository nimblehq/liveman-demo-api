defmodule Liveman.Survey.Schemas.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Liveman.Survey.Schemas.Survey

  @primary_key {:id, :string, autogenerate: false}

  schema "questions" do
    field(:correct_answer_id, :integer)
    field(:cover_background_color, :string)
    field(:cover_image_opacity, :float)
    field(:cover_image_url, :string)
    field(:display_order, :integer)
    field(:display_type, :string)
    field(:facebook_profile, :string)
    field(:font_face, :string)
    field(:font_size, :string)
    field(:help_text, :string)
    field(:image_url, :string)
    field(:is_mandatory, :boolean, default: false)
    field(:is_shareable_on_facebook, :boolean, default: false)
    field(:is_shareable_on_twitter, :string)
    field(:pick, :string)
    field(:short_text, :string)
    field(:tag_list, :string)
    field(:text, :string)
    field(:twitter_profile, :string)

    belongs_to(:survey, Survey, foreign_key: :survey_id, type: :string)

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [
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
      :font_face,
      :tag_list,
      :survey_id
    ])
    |> validate_required([
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
      :font_face,
      :tag_list
    ])
    |> assoc_constraint(:survey)
  end
end
