defmodule Hexling.Usage do
  @moduledoc """
  Tokens consumed by a request
  """

  defstruct [:completion_tokens, :response_tokens, :total_tokens]
end
