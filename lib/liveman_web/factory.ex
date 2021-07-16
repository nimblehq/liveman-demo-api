defmodule LivemanWeb.Factory do
  use ExMachina.Ecto, repo: Liveman.Repo

  use Liveman.User.UserFactory
  use Liveman.Survey.SurveyFactory
end
