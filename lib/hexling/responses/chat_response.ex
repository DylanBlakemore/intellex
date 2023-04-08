defmodule Hexling.Responses.ChatResponse do
  @moduledoc """
  A response from an LLM when using a chat model
  """

  defstruct [:finish_reason, :index, :content, :role]
end
