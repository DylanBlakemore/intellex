defmodule Intellex.ResponseTest do
  use ExUnit.Case

  alias Intellex.Response

  test "new!/1" do
    response_data = [
      content: "Hello",
      role: "bot",
      completion_tokens: 1,
      response_tokens: 1,
      total_tokens: 2,
      model: "gpt2"
    ]

    response = Response.new!(response_data)

    assert response.message.content == "Hello"
    assert response.message.role == "bot"
    assert response.metadata.completion_tokens == 1
    assert response.metadata.response_tokens == 1
    assert response.metadata.total_tokens == 2
    assert response.metadata.model == "gpt2"
  end
end
