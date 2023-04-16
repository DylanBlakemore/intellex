defmodule Intellex.ResponseHandlerTest do
  use ExUnit.Case

  alias Intellex.{Message, ResponseHandler}

  test "handle_response returns {:continue, response} when the status is incomplete" do
    message = %Message{content: "[STATUS: Incomplete]"}
    assert {:action, ^message} = ResponseHandler.handle_response(message)
  end

  test "handle_response returns {:terminate, response} when the status is complete" do
    message = %Message{content: "[STATUS: Complete]"}
    assert {:complete, ^message} = ResponseHandler.handle_response(message)
  end

  test "handle_response returns {:error, response} when the status is failed" do
    message = %Message{content: "[STATUS: Failed]"}
    assert {:failed, ^message} = ResponseHandler.handle_response(message)
  end

  test "handle_response returns {:error, response} when the status is unknown" do
    message = %Message{content: "[STATUS: Unknown]"}
    assert {:error, "Unknown status: Unknown"} = ResponseHandler.handle_response(message)
  end

  test "handle_response returns {:error, response} when the status is missing" do
    message = %Message{content: "Some content"}
    assert {:error, "Unknown response format"} = ResponseHandler.handle_response(message)
  end
end
