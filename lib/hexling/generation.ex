defmodule Hexling.Generation do
  @moduledoc """
  The result of a generation request
  """

  defstruct [:data, :usage, :type, :model]
end
