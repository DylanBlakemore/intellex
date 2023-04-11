defmodule Intellex.MessageTest do
  use ExUnit.Case

  alias Intellex.Message

  test "human" do
    assert %Message{type: "human", content: "Hello"} = Message.human("Hello")
  end

  test "ai" do
    assert %Message{type: "ai", content: "Hello"} = Message.ai("Hello")
  end

  test "system" do
    assert %Message{type: "system", content: "Hello"} = Message.system("Hello")
  end

  test "chat" do
    assert %Message{type: "chat", content: "Hello"} = Message.chat("Hello")
  end
end
