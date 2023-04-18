defmodule Intellex.LLMOpenAITest do
  use ExUnit.Case

  setup do
    Application.put_env(:openai, :api_url, "http://localhost:8082")
  end

  test "chat" do
    message = %Intellex.Message{role: "user", content: "Hello"}
    chain = Intellex.Chain.new!([message])
    assert {:ok, %Intellex.Response{}} = Intellex.LLM.chat(chain)
  end
end
