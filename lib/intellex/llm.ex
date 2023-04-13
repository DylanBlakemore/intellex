defmodule Intellex.LLM do
  @moduledoc """
  Defines a set of behaviours for an LLM instance
  """

  alias Intellex.Response

  defstruct [:model]
  @type t :: %__MODULE__{}

  @callback new!(Model.t()) :: t()
  @callback chat(t(), Chain.t()) :: {:ok, Response.t()} | {:error, any()}
end
