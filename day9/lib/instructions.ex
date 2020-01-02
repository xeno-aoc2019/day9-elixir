defmodule Instructions do

  @instructions %{
    1 => %Instruction{
      opcode: 1,
      name: "ADD",
      steps: 4
    },
    2 => %Instruction{
      opcode: 2,
      name: "MUL",
      steps: 4
    },
    3 => %Instruction{
      opcode: 3,
      name: "INPUT",
      steps: 2
    },
    4 => %Instruction{
      opcode: 4,
      name: "OUTPUT",
      steps: 2
    },
    5 => %Instruction{
      opcode: 5,
      name: "JT",
      steps: 3
    },
    6 => %Instruction{
      opcode: 6,
      name: "JF",
      steps: 3
    },
    7 => %Instruction{
      opcode: 7,
      name: "JLT",
      steps: 4
    },
    8 => %Instruction{
      opcode: 8,
      name: "JEQ",
      steps: 4
    },
    9 => %Instruction{
      opcode: 9,
      name: "RBO",
      steps: 2
    },
    99 => %Instruction{
      opcode: 99,
      name: "HALT",
      steps: 0
    }
  }

  def opcode(instr) do
    flags = rem(instr, 100)
  end

  def mode(instr, 1) do
    flags = Kernel.trunc(instr / 100)
    rem(flags, 10)
  end

  def mode(instr, 2) do
    flags = Kernel.trunc(instr / 1000)
    rem(flags, 10)
  end

  def mode(instr, 3) do
    flags = Kernel.trunc(instr / 10000)
    rem(flags, 10)
  end

end
