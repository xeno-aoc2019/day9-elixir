defmodule Storage do

  defp str2int(str) do
    {res, _} = Integer.parse(str)
    res
  end

  def read_program(filename) do
    string = File.read!(filename)
    strings = String.split(string, ",")
    list = Enum.map(strings, &str2int(&1))
    0..length(list)
    |> Stream.zip(list)
    |> Enum.into(%{})
  end

end
