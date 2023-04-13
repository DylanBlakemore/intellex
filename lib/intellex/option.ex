defmodule Intellex.Option do
  @moduledoc """
  An option is a parameter which can be passed to a tool's run function
  """
  defstruct [:name, :description, :type, :default, :optional]
end
