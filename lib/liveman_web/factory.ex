defmodule LivemanWeb.Factory do
  use ExMachina.Ecto, repo: Liveman.Repo

  use LivemanWeb.User.UserFactory
end
