defmodule Intellex.ActionTest do
  use ExUnit.Case

  alias Intellex.{Action, Message}

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

  test "new! with no options parses correctly" do
    assert %Action{
             tool: "test_tool_1",
             options: []
           } =
             Action.new!(
               "Some extra fluff that the LLM is definitely going to add because AIs be AIs'\n[TOOL: test_tool_1]. Maybe something on the end"
             )
  end

  describe "run" do
    setup do
      tools = [
        %Intellex.Tool{
          name: "hello",
          description: "Says hello to someone",
          options: [
            %{
              name: "name",
              description: "The name of the person to say hello to"
            }
          ],
          function: fn opts -> {:ok, "Hello #{opts["name"]}"} end
        }
      ]

      %{tools: tools}
    end

    test "when everything works correctly", %{tools: tools} do
      result =
        Action.run(
          %Action{
            tool: "hello",
            options: [
              {"name", "world"}
            ]
          },
          %Intellex.Toolkit{tools: tools}
        )

      assert {:ok, %Message{content: "Hello world", role: "user"}} = result
    end
  end
end
