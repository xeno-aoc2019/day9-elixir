defmodule Instruction do
  @enforce_keys [:opcode, :name, :steps]
  defstruct [:opcode, :name, :steps]
end