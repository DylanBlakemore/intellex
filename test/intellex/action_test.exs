defmodule Intellex.ActionTest do
  use ExUnit.Case

  alias Intellex.Action

  test "new! parses an action from a string" do
    assert %Action{
             tool: "test_tool_1",
             options: [
               {"option1", "value1"},
               {"option2", "value2"}
             ]
           } =
             Action.new!(
               "Some extra fluff that the LLM is definitely going to add because AIs be AIs'\n[TOOL: test_tool_1] [OPTIONS: option1: value1, option2: value2]. Maybe something on the end"
             )
  end
end
