defmodule Intellex.LLMs.OpenAITest do
  use ExUnit.Case

  setup do
    Application.put_env(:openai, :api_url, "http://localhost:8082")
  end

  test "new!" do
    model = %Intellex.Model{id: "gpt-3.5-turbo", max_tokens: 256, temperature: 0.7}
    assert %Intellex.LLM{model: ^model} = Intellex.LLMs.OpenAI.new!(model)
  end

  test "chat" do
    model = %Intellex.Model{id: "gpt-3.5-turbo", max_tokens: 256, temperature: 0.7}
    llm = Intellex.LLMs.OpenAI.new!(model)
    message = %Intellex.Message{role: "human", content: "Hello"}
    chain = Intellex.Chain.new!([message])
    assert {:ok, %Intellex.Response{}} = Intellex.LLMs.OpenAI.chat(llm, chain)
  end
end
