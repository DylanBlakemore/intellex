defmodule Intellex.ChainTest do
  use ExUnit.Case

  alias Intellex.{Chain, Message}

  @messages [
    Message.system("You are a useful assistant"),
    Message.human("Hello, how are you?")
  ]

  test "new!/1" do
    assert %Chain{messages: []} = Chain.new!()
  end

  test "new!/2" do
    assert %Chain{messages: @messages} = Chain.new!(@messages)
  end

  test "link" do
    chain = Chain.new!(@messages)
    message = Message.assistant("I am a robot")
    assert @messages ++ [message] == Chain.link(chain, message).messages
  end

  test "prompt" do
    chain = Chain.new!(@messages)

    assert [
             %{"role" => "system", "text" => "You are a useful assistant"},
             %{"role" => "human", "text" => "Hello, how are you?"}
           ] == Chain.prompt(chain)
  end
end
