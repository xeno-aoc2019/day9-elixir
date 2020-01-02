defmodule InstructionTest do
  use ExUnit.Case
  doctest Instruction

  test "can read out mode for field 1" do
    assert Instruction.mode(1204, 1) == 2
  end

  test "can read out default mode for field 1" do
    assert Instruction.mode(4, 1) == 0
  end

  test "can read out mode for field 2" do
    assert Instruction.mode(2104, 2) == 2
  end

  test "can read out mode for field 3" do
    assert Instruction.mode(11204, 3) == 1
  end

  test "can read out default mode for field 3" do
    assert Instruction.mode(1204, 3) == 0
  end

end
