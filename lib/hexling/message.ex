defmodule Hexling.Message do
  @moduledoc """
  Defines a Message which is sent to the LLM server
  """

  defstruct [:type, :content]

  @type t :: %__MODULE__{}

  @spec human(String.t()) :: t()
  def human(content) do
    %__MODULE__{type: "human", content: content}
  end

  @spec ai(String.t()) :: t()
  def ai(content) do
    %__MODULE__{type: "ai", content: content}
  end

  @spec system(String.t()) :: t()
  def system(content) do
    %__MODULE__{type: "system", content: content}
  end

  @spec chat(String.t()) :: t()
  def chat(content) do
    %__MODULE__{type: "chat", content: content}
  end
end
