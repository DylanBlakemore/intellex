defmodule Intellex.LLM do
  @moduledoc """
  OpenAI's LLM
  """

  alias Intellex.{Chain, Response}

  @doc """
  Result of a chat
  """
  @spec chat(Chain.t()) :: {:ok, Response.t()} | {:error, any()}
  def chat(chain) do
    OpenAI.chat_completion(
      model: "gpt-3.5-turbo",
      prompt: Chain.prompt(chain),
      max_tokens: 2048,
      temperature: 0.7
    )
    |> format()
  end

  defp format({:error, error}), do: {:error, error}

  defp format({:ok, %{usage: usage, model: model, choices: choices}}) do
    choice = Enum.at(choices, 0)

    {:ok,
     Response.new!(
       content: choice["message"]["content"],
       role: choice["message"]["role"],
       completion_tokens: usage["completion_tokens"],
       response_tokens: usage["response_tokens"],
       total_tokens: usage["total_tokens"],
       model: model
     )}
  end
end
