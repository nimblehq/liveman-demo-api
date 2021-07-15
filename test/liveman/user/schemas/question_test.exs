defmodule Liveman.Survey.Schemas.QuestionTest do
  use Liveman.DataCase, async: true

  alias Liveman.Survey.Schemas.Question

  describe "changeset/2" do
    test "returns valid changeset if given valid params" do
      attr = params_for(:question)

      changeset = Question.changeset(%Question{}, attr)

      assert changeset.valid?
    end

    test "returns invalid changeset if required params are missing" do
      changeset = Question.changeset(%Question{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               survey_id: ["can't be blank"],
               text: ["can't be blank"]
             }
    end
  end
end
