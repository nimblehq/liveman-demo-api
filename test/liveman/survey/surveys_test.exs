defmodule Liveman.Survey.SurveysTest do
  use Liveman.DataCase, async: true

  alias Liveman.Survey.Surveys

  describe "list_surveys/0" do
    test "returns the survey list" do
      survey_list = Surveys.list_surveys()

      assert Enum.count(survey_list) == 20
    end
  end
end
