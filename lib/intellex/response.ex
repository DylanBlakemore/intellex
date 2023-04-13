defmodule Intellex.Response do
  @moduledoc """
  A response from an LLM API call, consisting of a message and metadata.
  The message contains the generated text, as well as the agent role. The
  metadata contains information about the completion process, such as the
  number of tokens used, and the model used.
  """
  defstruct [:message, :metadata]

  @type t :: %__MODULE__{}

  @doc """
  Creates a new response struct from a map of response data.
  """
  @spec new!(keyword()) :: t()
  def new!(response_data) do
    %__MODULE__{
      message: %Intellex.Message{
        content: response_data[:content],
        role: response_data[:role]
      },
      metadata: %{
        completion_tokens: response_data[:completion_tokens],
        response_tokens: response_data[:response_tokens],
        total_tokens: response_data[:total_tokens],
        model: response_data[:model]
      }
    }
  end
end
