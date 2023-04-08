defmodule Hexling.Model do
  @moduledoc """
  Represents an LLM model
  """

  defstruct [:id, :max_tokens, :temperature]

  @type t :: %__MODULE__{}

  @default_max_tokens 256
  @default_temperature 0.7
  @default_id "gpt-3.5-turbo"

  @doc """
  Creates a new model
  """
  @spec new!(String.t(), keyword()) :: t()
  def new!(id, opts \\ []) do
    %__MODULE__{
      id: id,
      max_tokens: opts[:max_tokens] || @default_max_tokens,
      temperature: opts[:temperature] || @default_temperature
    }
  end

  @spec new!() :: t()
  def new!() do
    new!(@default_id)
  end
end
