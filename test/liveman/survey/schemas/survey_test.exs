defmodule Liveman.Survey.Schemas.SurveyTest do
  use Liveman.DataCase, async: true

  alias Liveman.Survey.Schemas.Survey

  describe "changeset/2" do
    test "returns valid changeset if given valid params" do
      attr = params_for(:survey)

      changeset = Survey.changeset(%Survey{}, attr)

      assert changeset.valid?
    end

    test "returns invalid changeset if required params are missing" do
      changeset = Survey.changeset(%Survey{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               created_at: ["can't be blank"],
               description: ["can't be blank"],
               title: ["can't be blank"],
               type: ["can't be blank"],
               id: ["can't be blank"]
             }
    end
  end
end
