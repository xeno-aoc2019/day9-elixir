defmodule Day9 do
  @moduledoc """
  Documentation for Day9.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day9.hello()
      :world

  """
  def hello do
    :world
  end


  def str2int(str) do
    {res, _} = Integer.parse(str)
    res
  end

  def read_file(filename) do
    string = File.read!(filename)
    strings = String.split(string,",")
    Enum.map(strings, &str2int(&1))
  end
end
