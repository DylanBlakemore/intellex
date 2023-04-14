defmodule Intellex.OptionTest do
  use ExUnit.Case

  alias Intellex.Option

  test "new! returns a new option" do
    assert %Option{name: "test"} = Option.new!(name: "test")
  end

  test "to_string returns a string representation of the option" do
    assert "option_1: The first option." =
             to_string(%Option{name: "option_1", description: "The first option"})
  end
end
