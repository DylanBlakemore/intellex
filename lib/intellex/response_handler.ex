defmodule Intellex.ResponseHandler do
  @moduledoc """
  The response handler is responsible for taking a response from the LLM and
  deciding what to do with it. It can either be a message, an action or a
  termination request
  """

  alias Intellex.Message

  @spec handle_response(Message.t()) :: {atom(), Message.t()} | {:error, String.t()}
  def handle_response(message) do
    case parse_status(message.content) do
      {:ok, "Incomplete"} -> {:action, message}
      {:ok, "Complete"} -> {:complete, message}
      {:ok, "Failed"} -> {:failed, message}
      {:ok, status} -> {:error, "Unknown status: #{status}"}
      {:error, _} -> {:error, "Unknown response format"}
    end
  end

  defp parse_status(content) do
    case Regex.run(~r/\[STATUS: (?<status>\w+)\]/, content) do
      [_, status] -> {:ok, status}
      _ -> {:error, "Unknown response format"}
    end
  end
end
