defmodule Intellex.Http.ErrorTest do
  use ExUnit.Case

  alias Intellex.Http.Error

  test "new!" do
    error = %HTTPoison.Error{reason: "test"}
    assert %Error{reason: "test"} = Error.new!(error)
  end
end
