defmodule StorageTest do
  use ExUnit.Case
  doctest Storage

  test "can read a file" do
    assert Storage.read_program("input_t1.txt") == %{0 => 104, 1 => 1125899906842624,2 => 99}
  end

end
