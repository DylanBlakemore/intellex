defmodule Intellex.AgentTest do
  use ExUnit.Case

  alias Intellex.{Agent, Chain, Message, Option, Toolkit, Tool}

  setup do
    Application.put_env(:openai, :api_url, "http://localhost:8082")

    tools = [
      %Tool{
        name: "multiply",
        description: "Multiplies two numbers",
        options: [
          %Option{name: "number_1", description: "The first number"},
          %Option{name: "number_2", description: "The second number"}
        ],
        function: fn options ->
          {number_1, _} = Float.parse(options["number_1"])
          {number_2, _} = Float.parse(options["number_2"])

          {:ok, "The result is: #{number_1 * number_2}"}
        end
      }
    ]

    toolkit = %Toolkit{
      name: "math",
      description: "Provides basic mathematic functions",
      tools: tools
    }

    {:ok, agent} =
      Agent.new(
        toolkit: toolkit,
        system: "You are a mock AI. The available tools are: multiply",
        prompt: "What is 2 * 2?"
      )

    %{toolkit: toolkit, agent: agent}
  end

  test "new", %{agent: agent, toolkit: toolkit} do
    assert agent.uuid != nil
    assert agent.system == "You are a mock AI. The available tools are: multiply"
    assert agent.prompt == "What is 2 * 2?"
    assert agent.toolkit == toolkit

    assert agent.chain ==
             Chain.new!([
               %Message{
                 content: "You are a mock AI. The available tools are: multiply",
                 role: "system"
               },
               %Message{
                 content: "What is 2 * 2?",
                 role: "user"
               }
             ])
  end

  test "run without errors", %{agent: agent} do
    assert {:ok, %Message{content: "[STATUS: Complete] [RESULT: 4]", role: "assistant"}} =
             Agent.run(agent)
  end
end
