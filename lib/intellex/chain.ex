defmodule Intellex.Chain do
  @moduledoc """
  A chain of messages to be sent to a LLM
  """

  alias Intellex.Message

  defstruct [:messages]

  @type t :: %__MODULE__{}

  @doc """
  Creates a new chain
  """
  @spec new!(list(Message.t())) :: t()
  def new!(messages \\ []) do
    %__MODULE__{messages: messages}
  end

  @doc """
  Adds a message to the chain
  """
  @spec add(t(), Message.t()) :: t()
  def add(chain, message) do
    %__MODULE__{chain | messages: chain.messages ++ [message]}
  end

  @doc """
  Converts a chain to a prompt
  """
  @spec prompt(t()) :: list(map())
  def prompt(chain) do
    chain.messages
    |> Enum.map(&Message.prompt/1)
  end
end
