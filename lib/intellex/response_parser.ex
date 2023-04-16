defmodule Intellex.ResponseParser do
  @status_regex ~r/\[STATUS: (?<status>\w+)\]/
  @tool_regex ~r/\[TOOL: (?<tool>\w+)\]/
  @options_regex ~r/\[OPTIONS: (?<options>([a-zA-Z0-9_ ,:]+))\]/

  def parse_status(content) do
    case Regex.run(@status_regex, content) do
      [_, status] -> {:ok, status}
      _ -> {:error, "Unknown response format"}
    end
  end

  def parse_tool(string) do
    string
    |> capture(@tool_regex)
    |> List.first()
  end

  def parse_options(string) do
    case match_options(string) do
      nil -> []
      matches -> parse_options_matches(matches)
    end
  end

  defp match_options(string) do
    string
    |> capture(@options_regex)
  end

  defp capture(string, regex) do
    Regex.run(regex, string, capture: :all_but_first)
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
