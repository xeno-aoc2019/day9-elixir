defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "can read a file" do
    assert Day9.read_file("input_t1.txt") == %{0 => 104, 1 => 1125899906842624,2 => 99}
  end

end
