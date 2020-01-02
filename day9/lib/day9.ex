defmodule Day9 do

# Modes

  def run(filename, input) do
    program = Storage.read_program(filename);
    memory = %Memory.Memory{program: program }
    memory
  end


### Input
  def read_file(filename) do
    Storage.read_program(filename)
  end

end
