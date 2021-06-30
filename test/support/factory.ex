defmodule Liveman.Factory do
  use ExMachina.Ecto, repo: Liveman.Repo

  use Liveman.User.UserFactory
end
