defmodule Intellex.Prompts.Tools do
  alias Intellex.PromptTemplate

  @spec instructions(String.t()) :: PromptTemplate.t()
  def instructions(toolkit, answer_format) do
    """
    You have access to a variety of tools to perform your job. A tool is a command which performs some function.
    Each tool has a unique name, and can accept zero or more options. To use a tool, specify the name of the tool, followed by any options you wish to pass to it.
    Use the following format to use a tool:

    [STATUS: Incomplete] [TOOL: tool_name] [OPTIONS: option_1: value_1, option_2: value_2]

    If you know the final answer to the question, respond with the following format:

    [STATUS: Complete] #{answer_format}

    If you do not know the answer, and do not think any of the tools are useful, answer in the following format:

    [STATUS: Failed] [REASON: <reason>]

    The list of available tools is as follows:

    #{toolkit}
    """
    |> PromptTemplate.new!()
    |> PromptTemplate.generate(%{tool_names: Enum.join(tool_names, ", ")})
  end
end
