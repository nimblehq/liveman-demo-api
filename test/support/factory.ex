defmodule Liveman.Factory do
  use ExMachina.Ecto, repo: Liveman.Repo

  use Liveman.User.UserFactory
  use Liveman.Survey.{SurveyFactory, QuestionFactory}
end
