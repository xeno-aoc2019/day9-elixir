defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "can read a file" do
    assert Day9.read_file("input_t1.txt") == %{0 => 104, 1 => 1125899906842624,2 => 99}
  end

  test "can execute input_t1.txt" do

  end

  test "can execute input_t2.txt" do
    mem = Day9.r2()
    Cpu.exec(mem)
  end

end
