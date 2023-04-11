defmodule Intellex.LLMs.LLM do
  @moduledoc """
  Defines a set of behaviours for a LLM instance
  """

  alias Intellex.Model
  alias Intellex.Generation

  @callback chat(Model.t(), Chain.t()) :: Generation.t()
end
