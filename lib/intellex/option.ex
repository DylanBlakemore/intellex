defmodule Intellex.Option do
  @moduledoc """
  An option is a parameter which can be passed to a tool's run function
  """
  defstruct [:name, :description]

  @type t :: %__MODULE__{}

  defimpl String.Chars do
    @spec to_string(Intellex.Option.t()) :: String.t()
    def to_string(option) do
      "#{option.name}: #{option.description}."
    end
  end

  @doc """
  Creates a new option
  """
  @spec new!(keyword()) :: %__MODULE__{}
  def new!(opts) do
    %__MODULE__{
      name: opts[:name],
      description: opts[:description]
    }
  end
end
