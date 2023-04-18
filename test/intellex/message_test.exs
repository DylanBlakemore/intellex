defmodule Intellex.MessageTest do
  use ExUnit.Case

  alias Intellex.Message

  test "user" do
    assert %Message{role: "user", content: "Hello"} = Message.user("Hello")
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
    message = Message.user("Hello")
    assert %{"role" => "user", "text" => "Hello"} = Message.prompt(message)
  end
end
