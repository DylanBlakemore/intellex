defmodule Hexling.Responses.CompletionResponse do
  @moduledoc """
  A response from an LLM when using a completion model
  """
  defstruct [:finish_reason, :index, :text]
end
