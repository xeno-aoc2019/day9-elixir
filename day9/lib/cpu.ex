defmodule Cpu do
  @moduledoc false

  defp s(i) do
    Integer.to_string(i)
  end

  defp read(memory, param, 0) do
    value = Memory.get(memory, param)
    IO.puts("read[0] param=" <> s(param) <> " -> " <> s(value))
    value
  end

  defp read(_memory, param, 1) do
    IO.puts("read[1] param=" <> s(param) <> " -> " <> s(param))
    param
  end

  defp read(memory, param, 2) do
    value = Memory.get(memory, memory.rb + param)
    IO.puts("read[2] param=" <> s(param) <> " -> " <> s(value))
    value
  end

  defp write(memory, param, value, 0) do
    IO.puts("write[0] param=" <> s(param) <> ":" <> s(param) <> " := " <> s(value))
    Memory.set(memory, param, value)
  end

  defp write(memory, param, value, 2) do
    address = memory.rb + param
    IO.puts("write[2] rb:param=" <> s(memory.rb) <> ":" <> s(param) <> "=" <> s(address) <> " := " <> s(value))
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
    if memory.input == [] do
      IO.puts("Input: no input available")
      Integer.to_string(nil)
    else
      [value | remaining] = memory.input
      IO.puts("*** Input value : " <> s(value))
      mem = write(memory, Memory.get_param(memory, 1), value, Instructions.mode(instr, 1))
      mem2 = Memory.step(mem, 2)
      mem2
    end
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
    mem = if value1 < value2 do
      write(memory, Memory.get_param(memory, 3), 1, Instructions.mode(instr, 3))
    else
      write(memory, Memory.get_param(memory, 3), 0, Instructions.mode(instr, 3))
    end
    Memory.step(mem, 4)
  end

  defp exec_inst(memory, 8, instr) do
    value1 = read(memory, Memory.get_param(memory, 1), Instructions.mode(instr, 1))
    value2 = read(memory, Memory.get_param(memory, 2), Instructions.mode(instr, 2))
    IO.puts("EQ " <> s(value1) <> "," <> s(value2))
    mem = if value1 == value2 do
      write(memory, Memory.get_param(memory, 3), 1, Instructions.mode(instr, 3))
    else
      write(memory, Memory.get_param(memory, 3), 0, Instructions.mode(instr, 3))
    end
    Memory.step(mem, 4)
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
    inst = Memory.get_instruction(memory)
    opcode = Instructions.opcode(inst)
    IO.puts("IP: " <> s(memory.ip) <> "->" <> s(inst) <> " RB: " <> s(memory.rb))
    IO.puts("program: " <> inspect(memory.program))
    if memory.halted do
      memory
    else
      mem = exec_inst(memory, opcode, inst)
      exec(mem)
      #      mem
    end
  end

end
