defmodule Intellex.Action do
  @moduledoc """
  An action is a command which the LLM can send to our application. It consists of
  a tool and a set of options which are passed to the tool's run function
  """
  defstruct [:tool, :options]

  @type t :: %__MODULE__{}

  alias Intellex.{Message, Parser}

  @doc """
  Parses a string into an action. The string takes the form
  '[TOOL: tool_name] [OPTIONS: option1: value1, option2: value2]'
  """
  @spec new!(String.t()) :: __MODULE__.t()
  def new!(string) do
    %__MODULE__{
      tool: Parser.parse_tool(string),
      options: Parser.parse_options(string)
    }
  end

  @doc """
  Runs an action using the given toolkit
  """
  @spec run(t(), Intellex.Toolkit.t()) :: {atom(), Message.t()}
  def run(action, toolkit) do
    with {:ok, tool} <- Intellex.Toolkit.get_tool(toolkit, action.tool),
         {:ok, tool} <- Intellex.Tool.validate(tool, action),
         {:ok, result} <- Intellex.Tool.run(tool, action) do
      {:ok, Message.user(result)}
    else
      {:error, error} -> {:error, Message.user(error)}
    end
  end
end
