defmodule Cpu do
  @moduledoc false

  defp read(memory, param, 0) do
    Memory.get(memory, param)
  end

  defp read(_memory, param, 1) do
    param
  end

  defp read(memory, param, 2) do
    Memory.get(memory, memory.rb + param)
  end

  defp write(memory, param, value, 0) do
    Memory.set(memory, param, value)
  end

  defp write(memory, param, value, 2) do
    address = memory.rb + param
    Memory.set(memory, address, value)
  end

  defp exec_inst(memory, 1, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    mem = write(memory, Memory.get_param(memory, 3), value1 + value2, Instructions.mode(instr, 3))
    Memory.step(mem, 4)
  end

  defp exec_inst(memory, 2, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    mem = write(memory, Memory.get_param(memory, 3), value1 * value2, Instructions.mode(instr, 3))
    Memory.step(mem, 4)
  end

  defp exec_inst(memory, 3, instr) do
    IO.puts("NOT IMPLEMENTED: Input")
    Memory.step(memory, 2)
  end

  defp exec_inst(memory, 4, instr) do
    value = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    mem = Memory.add_output(memory, value)
    Memory.step(mem, 2)
  end

  defp exec_inst(memory, 5, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    if value1 === 1 do
      Memory.goto(memory, value2)
    else
      Memory.step(memory, 3)
    end
  end

  defp exec_inst(memory, 6, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    if value1 === 0 do
      Memory.goto(memory, value2)
    else
      Memory.step(memory, 3)
    end
  end

  defp exec_inst(memory, 7, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    value3 = read(memory, Memory.get_param(memory, 3), Instructions.mode(instr, 3))
    if value1 < value2 do
      Memory.goto(memory, value3)
    else
      Memory.step(memory, 4)
    end
  end

  defp exec_inst(memory, 8, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    value3 = read(memory, Memory.get_param(memory, 3), Instructions.mode(instr, 3))
    if value1 === value2 do
      Memory.goto(memory, value3)
    else
      Memory.step(memory, 4)
    end
  end

  defp exec_inst(memory, 9, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    mem = Memory.add_rb(memory, value1)
    Memory.step(mem, 2)
  end

  defp exec_inst(memory, 99, _instr) do
    Memory.halt(memory)
  end


  def exec(memory) do
    i = Memory.get_instruction(memory)
    IO.puts(i)
    opcode = Instructions.opcode(i)
    exec_inst(memory, opcode, i)
  end

end
