defmodule Intellex.Toolkit do
  @moduledoc """
  A toolkit is a collection of tools which allows the LLM to interact with our application
  """

  defstruct [:name, :description, :tools]
end
