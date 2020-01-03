defmodule Memory do
  defmodule Memory do
    defstruct program: %{},
              ip: 0,
              rb: 0,
              halted: false,
              iowait: false,
              input: [],
              output: []
  end

  def get_instruction(memory) do
    memory.program[memory.ip]
  end

  def add_input(memory, input) do
    %{memory | input: memory.input ++ [input]}
  end

  def add_output(memory, output) do
    %{memory | output: memory.output ++ [output]}
  end

  def set(memory, index, value) do
    %{
      memory |
      program: Map.put(memory.program, index, value)
    }
  end

  def get(memory, index) do
    value = memory.program[index]
    if value == nil do
      0
    else
      value
    end
  end

  def halt(memory) do
    %{memory | halted: true}
  end

  def add_rb(memory, value) do
    %{memory | rb: memory.rb + value}
  end

  def goto(memory, address) do
    %{memory | ip: address}
  end

  def step(memory, steps) do
    %{memory | ip: memory.ip + steps}
  end

  def get_param(memory, param) do
    memory.program[memory.ip + param]
  end

end
