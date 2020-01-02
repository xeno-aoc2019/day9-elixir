defmodule Cpu do
  @moduledoc false

  defp read(memory, param, 0) do
    memory.get(param)
  end

  defp read(memory, param, 1) do
    param
  end

  defp read(memory, param, 2) do
    memory.get(memory.rb + param)
  end

  defp exec_inst(memory, 1, instr) do
    IO.puts("calling exec_inst:1")
  end

  defp exec_inst(memory, 4, instr) do
    value = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    mem = Memory.add_output(memory, value)
    Memory.step(memory, 2)
  end

  defp exec_inst(memory, 99, _instr) do
    Memory.halt(memory)
  end


  def exec(memory) do
    i = Memory.get_instruction(memory)
    opcode = Instructions.opcode(i)
    exec_inst(memory, opcode, i)
  end

end
