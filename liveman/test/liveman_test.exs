defmodule LivemanTest do
  use ExUnit.Case
  doctest Liveman

  test "greets the world" do
    assert Liveman.hello() == :world
  end
end
