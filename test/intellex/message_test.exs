defmodule Intellex.MessageTest do
  use ExUnit.Case

  alias Intellex.Message

  test "human" do
    assert %Message{role: "human", content: "Hello"} = Message.human("Hello")
  end

  test "assistant" do
    assert %Message{role: "assistant", content: "Hello"} = Message.assistant("Hello")
  end

  test "system" do
    assert %Message{role: "system", content: "Hello"} = Message.system("Hello")
  end

  test "chat" do
    assert %Message{role: "chat", content: "Hello"} = Message.chat("Hello")
  end

  test "prompt" do
    message = Message.human("Hello")
    assert %{"role" => "human", "text" => "Hello"} = Message.prompt(message)
  end
end
