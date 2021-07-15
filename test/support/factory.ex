defmodule Liveman.Factory do
  use ExMachina.Ecto, repo: Liveman.Repo

  use Liveman.User.UserFactory
  # credo:disable-for-next-line Credo.Check.Consistency.MultiAliasImportRequireUse
  use Liveman.Survey.{SurveyFactory, QuestionFactory}
end
