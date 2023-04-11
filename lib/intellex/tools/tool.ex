defmodule Intellex.Tool do
  @moduledoc """
  A tool is a function which allows the LLM to interact with our application
  """
  defstruct [:name, :description, :function]
end
