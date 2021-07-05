defmodule LivemanApiTest do
  use ExUnit.Case
  doctest LivemanApi

  test "greets the world" do
    assert LivemanApi.hello() == :world
  end
end
