defmodule Intellex.ToolkitTest do
  use ExUnit.Case

  alias Intellex.Toolkit

  test "get_tool returns {:error, 'Tool not found: missing_tool'} when the tool is not available" do
    toolkit = %Toolkit{name: "test", description: "test", tools: []}
    assert {:error, "Tool not found: missing_tool"} = Toolkit.get_tool(toolkit, "missing_tool")
  end

  test "get_tool returns {:ok, tool} when the tool is available" do
    tool = %Intellex.Tool{name: "test", description: "test", options: []}
    toolkit = %Toolkit{name: "test", description: "test", tools: [tool]}
    assert {:ok, ^tool} = Toolkit.get_tool(toolkit, "test")
  end
end
