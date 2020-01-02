defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "greets the world" do
    assert Day9.hello() == :world
  end

  test "can read a file" do
    assert Day9.read_file("input_t1.txt") == [104,1125899906842624,99]
  end
end
