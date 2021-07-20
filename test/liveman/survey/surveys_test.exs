defmodule Liveman.Survey.SurveysTest do
  use Liveman.DataCase, async: true

  alias Liveman.Survey.Surveys

  describe "list_surveys/0" do
    test "returns the survey list" do
      survey_list = Surveys.list_surveys()

      assert Enum.count(survey_list) == 20
    end
  end

  describe "create_answers/1" do
    test "returns :ok when params are valid" do
      params = %{
        "survey_id" => "d5de6a8f8f5f1cfe51bc",
        "questions" => [
          %{
            "id" => "940d229e4cd87cd1e202",
            "answers" => [
              %{
                "id" => "037574cb93d16800eecd"
              }
            ]
          }
        ]
      }

      result = Surveys.create_answers(params)

      assert result == :ok
    end

    test "returns {:error, :invalid_questions} tuple when params are invalid" do
      params = %{
        "survey_id" => "d5de6a8f8f5f1cfe51bc",
        "questions" => [
          %{
            "id" => "invalid",
            "answers" => [
              %{
                "id" => "037574cb93d16800eecd"
              }
            ]
          }
        ]
      }

      result = Surveys.create_answers(params)

      assert result == {:error, :invalid_questions}
    end
  end
end
