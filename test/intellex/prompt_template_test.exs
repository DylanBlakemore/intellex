defmodule Intellex.PromptTemplateTest do
  use ExUnit.Case

  alias Intellex.PromptTemplate

  test "new! returns a new template" do
    template = PromptTemplate.new!("{{name}} is {{age}} years old")
    assert template.template == "{{name}} is {{age}} years old"
    assert template.variables == ["name", "age"]
  end

  describe "generate" do
    test "returns a string with the variables replaced" do
      template = PromptTemplate.new!("{{name}} is {{age}} years old")
      {:ok, prompt} = PromptTemplate.generate(template, %{"name" => "John", "age" => 30})
      assert prompt == "John is 30 years old"
    end

    test "returns an error if a variable is missing" do
      template = PromptTemplate.new!("{{name}} is {{age}} years old")

      assert PromptTemplate.generate(template, %{"name" => "John"}) ==
               {:error, "Missing variable: age"}
    end
  end
end
