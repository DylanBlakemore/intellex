defmodule Hexling.LLMs.LLM do
  @moduledoc """
  Defines a set of behaviours for a LLM instance
  """

  alias Hexling.Model
  alias Hexling.Generation

  @callback chat(Model.t(), Chain.t()) :: Generation.t()
end
