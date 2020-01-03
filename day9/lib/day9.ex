defmodule Day9 do

  require Logger

  # Modes

  def run(filename, input) do
    program = Storage.read_program(filename);
    memory = %Memory.Memory{program: program, input: input}
    Cpu.exec(memory)
  end


  ### Input
  def read_file(filename) do
    Storage.read_program(filename)
  end

  def r2 do
    mem = run("input_t2.txt", [])
    processed = Cpu.exec(mem)
    [head | tail] = processed.output
    IO.puts("Output: " <> Integer.to_string(head))
    processed
  end

  def r3 do
    mem = run("input_t3.txt", [])
    processed = Cpu.exec(mem)
    [head | tail] = processed.output
    IO.puts("Output: " <> Integer.to_string(head))
    processed
  end

  def real do
    mem = run("input.txt", [1])
    processed = Cpu.exec(mem)
    [head | tail] = processed.output
    IO.puts("Output: " <> Integer.to_string(head))
    processed
  end

  def real5 do
    mem = run("input5.txt", [8])
    processed = Cpu.exec(mem)
    [head | tail] = processed.output
    IO.puts("Output: " <> Integer.to_string(head))
    processed
  end

end
