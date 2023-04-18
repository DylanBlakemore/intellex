defmodule Intellex.ParserTest do
  use ExUnit.Case

  alias Intellex.Parser

  describe "parse_status/1" do
    test "returns the status" do
      assert {:ok, "Complete"} = Parser.parse_status("[STATUS: Complete]")
    end

    test "returns an error if the status is missing" do
      assert {:error, "Unknown response format"} = Parser.parse_status("Hello")
    end
  end

  describe "parse_tool/1" do
    test "returns the tool" do
      assert {:ok, "tool"} = Parser.parse_tool("[TOOL: tool]")
    end

    test "returns an error if the tool is missing" do
      assert {:error, "Unknown response format"} = Parser.parse_tool("Hello")
    end
  end

  describe "parse_options/1" do
    test "returns the options" do
      assert {:ok, [{"option", "value"}]} = Parser.parse_options("[OPTIONS: option: value]")
    end

    test "multiple options" do
      assert {:ok, [{"option", "value"}, {"option2", "value2"}]} =
               Parser.parse_options("[OPTIONS: option: value, option2: value2]")
    end

    test "no options" do
      assert {:ok, []} = Parser.parse_options("Hello")
    end
  end
end
