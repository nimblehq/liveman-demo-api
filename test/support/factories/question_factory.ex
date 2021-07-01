defmodule Liveman.Survey.QuestionFactory do
  alias Liveman.Survey.Schemas.Question

  defmacro __using__(_opts) do
    quote do
      def question_factory do
        %Question{
          id: Faker.UUID.v4(),
          text: Faker.Lorem.sentence(3),
          help_text: Faker.Lorem.sentence(5),
          survey_id: Faker.UUID.v4()
        }
      end
    end
  end
end
