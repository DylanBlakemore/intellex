defmodule Intellex.ToolTest do
  use ExUnit.Case

  alias Intellex.Tool

  test "new! returns a new tool" do
    assert %Tool{name: "test"} = Tool.new!("test")
  end

  test "description returns a tool with a description" do
    assert %Tool{description: "test"} = Tool.description(%Tool{}, "test")
  end

  test "function returns a tool with a function" do
    assert %Tool{function: :my_func} = Tool.function(%Tool{}, :my_func)
  end

  test "option returns a tool with an option" do
    assert %Tool{options: [%Intellex.Option{}]} =
             Tool.option(%Tool{options: []}, %Intellex.Option{})
  end
end
