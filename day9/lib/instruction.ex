defmodule Instruction do
  @moduledoc false

  def mode(instr, 1) do
    flags = Kernel.trunc(instr/100)
    rem(flags, 10)
  end

  def mode(instr, 2) do
    flags = Kernel.trunc(instr/1000)
    rem(flags, 10)
  end

  def mode(instr, 3) do
    flags = Kernel.trunc(instr/10000)
    rem(flags, 10)
  end

end
