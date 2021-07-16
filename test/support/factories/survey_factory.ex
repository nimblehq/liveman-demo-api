defmodule Liveman.Survey.SurveyFactory do
  alias Liveman.Survey.Schemas.Survey

  defmacro __using__(_opts) do
    quote do
      def survey_factory do
        %Survey{
          id: Faker.UUID.v4(),
          title: Faker.Lorem.sentence(3),
          description: Faker.Lorem.sentence(5),
          thank_email_above_threshold: Faker.Lorem.paragraph(),
          thank_email_below_threshold: Faker.Lorem.paragraph(),
          is_active: true,
          cover_image_url: Faker.Internet.image_url(),
          type: "Restaurant",
          created_at: Faker.DateTime.backward(7),
          active_at: Faker.DateTime.backward(6)
        }
      end
    end
  end
end
