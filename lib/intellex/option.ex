defmodule Intellex.Option do
  @moduledoc """
  An option is a parameter which can be passed to a tool's run function
  """
  defstruct [:name, :description, :type, :default, :optional]

  @spec new!(keyword()) :: %__MODULE__{}
  def new!(opts) do
    %__MODULE__{
      name: opts[:name],
      description: opts[:description],
      type: opts[:type],
      default: opts[:default],
      optional: opts[:optional]
    }
  end
end
