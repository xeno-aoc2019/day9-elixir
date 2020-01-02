
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


end
