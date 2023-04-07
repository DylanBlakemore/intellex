defmodule Hexling.Http.ErrorTest do
  use ExUnit.Case

  alias Hexling.Http.Error

  test "new!" do
    error = %HTTPoison.Error{reason: "test"}
    assert %Error{reason: "test"} = Error.new!(error)
  end
end
