defmodule SayNextTest do
  use ExUnit.Case
  doctest SayNext

  test "greets the world" do
    assert SayNext.hello() == :world
  end
end
