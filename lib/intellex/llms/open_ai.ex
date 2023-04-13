defmodule Intellex.LLMs.OpenAI do
  @moduledoc """
  OpenAI's LLM
  """

  @behaviour Intellex.LLM

  alias Intellex.{Chain, LLM, Model, Response}

  @doc """
  Creates a new OpenAI LLM instance
  """
  @spec new!(Model.t()) :: LLM.t()
  def new!(model) do
    %LLM{model: model}
  end

  @doc """
  Result of a chat
  """
  @spec chat(LLM.t(), Chain.t()) :: {:ok, Response.t()} | {:error, any()}
  def chat(%LLM{model: model}, chain) do
    OpenAI.chat_completion(
      model: model.id,
      prompt: Chain.prompt(chain),
      max_tokens: model.max_tokens,
      temperature: model.temperature
    )
    |> format()
  end

  defp format({:error, error}), do: {:error, error}

  defp format({:ok, %{usage: usage, model: model, choices: choices}}) do
    choice = Enum.at(choices, 0)

    {:ok,
     Response.new!(
       content: choice["content"],
       role: choice["role"],
       completion_tokens: usage["completion_tokens"],
       response_tokens: usage["response_tokens"],
       total_tokens: usage["total_tokens"],
       model: model
     )}
  end
end
