defmodule Intellex.ModelTest do
  use ExUnit.Case

  alias Intellex.Model

  test "new!/1" do
    assert %Model{id: "my-model", max_tokens: 256, temperature: 0.7} = Model.new!("my-model")
  end

  test "new!/2" do
    assert %Model{id: "my-model", max_tokens: 5, temperature: 0.1} =
             Model.new!("my-model", %{max_tokens: 5, temperature: 0.1})
  end

  test "new!/0" do
    assert %Model{id: "gpt-3.5-turbo", max_tokens: 256, temperature: 0.7} = Model.new!()
  end
end
