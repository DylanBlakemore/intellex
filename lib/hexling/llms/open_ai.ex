defmodule Hexling.LLMs.OpenAI do
  @moduledoc """
  OpenAI's LLM
  """

  @behaviour Hexling.LLMs.LLM

  alias Hexling.Chain
  alias Hexling.Model
  alias Hexling.Generation
  alias Hexling.Usage
  alias Hexling.Responses.{ChatResponse, CompletionResponse}

  @doc """
  Result of a chat generation
  """
  @spec chat(Model.t(), Chain.t()) :: {:ok, Generation.t()} | {:error, any()}
  def chat(model, chain) do
    OpenAI.chat_completion(
      model: model.id,
      prompt: Chain.to_prompt(chain),
      max_tokens: model.max_tokens,
      temperature: model.temperature
    )
    |> format()
  end

  @doc """
  Result of a completion generation
  """
  @spec completion(Model.t(), String.t()) :: {:ok, Generation.t()} | {:error, any()}
  def completion(model, prompt) do
    OpenAI.completions(
      model: model.id,
      prompt: prompt,
      max_tokens: model.max_tokens,
      temperature: model.temperature
    )
    |> format()
  end

  defp format(result, type, response_format) do
    usage = %Usage{
      completion_tokens: result.completion_tokens,
      response_tokens: result.response_tokens,
      total_tokens: result.total_tokens
    }

    data = result.choices |> Enum.map(fn choice -> response_format.(choice) end)

    {:ok,
     %Generation{
       data: data,
       usage: usage,
       type: type,
       model: result.model
     }}
  end

  defp format({:error, error}), do: {:error, error}

  defp format({:ok, %{object: "chat.completion"} = result}) do
    format(result, :chat, fn choice ->
      %ChatResponse{
        index: choice.index,
        content: choice.message.content,
        role: choice.message.role,
        finish_reason: choice.finish_reason
      }
    end)
  end

  defp format({:ok, %{object: "completion"} = result}) do
    format(result, :completion, fn choice ->
      %CompletionResponse{
        index: choice.index,
        text: choice.text,
        finish_reason: choice.finish_reason
      }
    end)
  end
end
