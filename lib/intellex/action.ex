defmodule Intellex.Action do
  @moduledoc """
  An action is a command which the LLM can send to our application. It consists of
  a tool and a set of options which are passed to the tool's run function
  """
  defstruct [:tool, :options]

  @type t :: %__MODULE__{}

  @doc """
  Parses a string into an action. The string takes the form
  '[TOOL: tool_name] [OPTIONS: option1: value1, option2: value2]'
  """
  @spec new!(String.t()) :: __MODULE__.t()
  def new!(string) do
    %__MODULE__{
      tool: parse_tool(string),
      options: parse_options(string)
    }
  end

  defp parse_tool(string) do
    Regex.run(~r/\[TOOL: (?<tool>\w+)\]/, string, capture: :all_but_first)
    |> List.first()
  end

  defp parse_options(string) do
    case match_options(string) do
      nil -> []
      matches -> parse_options_matches(matches)
    end
  end

  defp match_options(string) do
    Regex.run(~r/\[OPTIONS: (?<options>([a-zA-Z0-9_ ,:]+))\]/, string, capture: :all_but_first)
  end

  defp parse_options_matches(matches) do
    matches
    |> List.first()
    |> String.split(", ")
    |> Enum.map(&parse_option/1)
  end

  defp parse_option(string) do
    [name, value] = String.split(string, ": ")
    {name, value}
  end
end
