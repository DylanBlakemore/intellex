defmodule Intellex.Toolkit do
  @moduledoc """
  A toolkit is a collection of tools which allows the LLM to interact with our application
  """
  defstruct [:name, :description, :tools]

  @type t :: %__MODULE__{}

  @spec get_tool(t(), String.t()) :: {:ok, Intellex.Tool.t()} | {:error, String.t()}
  def get_tool(toolkit, name) do
    case find_tool(toolkit, name) do
      nil -> {:error, "Tool not found: #{name}"}
      tool -> {:ok, tool}
    end
  end

  defp find_tool(toolkit, name) do
    Enum.find(toolkit.tools, fn tool -> tool.name == name end)
  end
end
