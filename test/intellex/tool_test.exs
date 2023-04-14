defmodule Intellex.ToolTest do
  use ExUnit.Case

  alias Intellex.{Action, Tool}

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

  describe "validate" do
    test "valid options" do
      tool = %Tool{
        name: "test_tool",
        options: [
          %Intellex.Option{name: "option1"},
          %Intellex.Option{name: "option2"}
        ]
      }

      action = %Action{
        options: [
          {"option1", "value1"},
          {"option2", "value2"}
        ]
      }

      assert {:ok, ^tool} = Tool.validate(tool, action)
    end

    test "invalid options" do
      tool = %Tool{
        name: "test_tool",
        options: [
          %Intellex.Option{name: "option1"},
          %Intellex.Option{name: "option2"}
        ]
      }

      action = %Action{
        options: [
          {"option1", "value1"},
          {"option3", "value2"}
        ]
      }

      assert {:error, "Invalid options for tool :test_tool"} = Tool.validate(tool, action)
    end
  end

  describe "run" do
    test "success case" do
      tool = %Tool{
        name: "test_tool",
        function: fn _options -> {:ok, "value_1, value_2"} end
      }

      action = %Action{
        options: [
          {"option1", "value1"},
          {"option2", "value2"}
        ]
      }

      assert {:ok, "value_1, value_2"} = Tool.run(tool, action)
    end

    test "error case" do
      tool = %Tool{
        name: "test_tool",
        function: fn _options -> raise "Error" end
      }

      action = %Action{
        options: [
          {"option1", "value1"},
          {"option2", "value2"}
        ]
      }

      assert {:error, "Error"} = Tool.run(tool, action)
    end
  end

  describe "to_string" do
    test "with no options displays the tool name and description" do
      tool = %Tool{
        name: "test_tool",
        description: "This is a test tool",
        options: []
      }

      assert "test_tool: This is a test tool." = to_string(tool)
    end

    test "with options displays the tool name, description and options" do
      tool = %Tool{
        name: "test_tool",
        description: "This is a test tool",
        options: [
          %Intellex.Option{name: "option1", description: "The first option"},
          %Intellex.Option{name: "option2", description: "The second option"}
        ]
      }

      assert "test_tool: This is a test tool. Available options:\n\toption1: The first option.\n\toption2: The second option." =
               to_string(tool)
    end
  end
end
