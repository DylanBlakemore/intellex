defmodule Intellex.Parser do
  @status_regex ~r/\[STATUS: (?<status>\w+)\]/
  @tool_regex ~r/\[TOOL: (?<tool>\w+)\]/
  @options_regex ~r/\[OPTIONS: (?<options>([a-zA-Z0-9_ ,:]+))\]/

  @doc """
  Extracts the status from the LLM response.

  Example:
  iex> Intellex.Parser.parse_status("[STATUS: Incomplete] [TOOL: tool] [OPTIONS: option1: description1, option2: description2]")
  {:ok, "Incomplete"}
  """
  @spec parse_status(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def parse_status(content) do
    case Regex.run(@status_regex, content) do
      [_, status] -> {:ok, status}
      _ -> {:error, "Unknown response format"}
    end
  end

  @doc """
  Extracts the tool from the LLM response.

  Example:
  iex> Intellex.Parser.parse_tool("[STATUS: Incomplete] [TOOL: tool] [OPTIONS: option1: description1, option2: description2]")
  {:ok, "tool"}
  """
  @spec parse_tool(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def parse_tool(string) do
    case Regex.run(@tool_regex, string) do
      [_, tool] -> {:ok, tool}
      _ -> {:error, "Unknown response format"}
    end
  end

  @spec parse_options(String.t()) :: {:ok, list()} | {:error, String.t()}
  def parse_options(string) do
    case Regex.run(@options_regex, string, capture: :all_but_first) do
      [_, options] -> {:ok, parse_options_string(options)}
      _ -> {:ok, []}
    end
  end

  defp parse_options_string(options) do
    options
    |> String.split(", ")
    |> Enum.map(&parse_option/1)
  end

  defp parse_option(string) do
    [name, value] = String.split(string, ": ")
    {name, value}
  end
end
