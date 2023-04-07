defmodule Hexling.OpenAi.Client do
  alias Hexling.Config
  alias Hexling.Http.{Response, Error}

  @spec headers() :: keyword()
  def headers() do
    Config.headers()
  end

  @spec get(String.t()) :: {:ok, Response.t()} | {:error, Error.t()}
  def get(path) do
    path
    |> build_path()
    |> HTTPoison.get(headers())
    |> handle_response()
  end

  @spec put(String.t(), map()) :: {:ok, Response.t()} | {:error, Error.t()}
  def put(path, body) do
    path
    |> build_path()
    |> HTTPoison.put(Jason.encode!(body), headers())
    |> handle_response()
  end

  defp build_path(path) do
    Config.api_base_url() <> path
  end

  defp handle_response({:ok, response}), do: {:ok, Response.new!(response)}
  defp handle_response({:error, error}), do: {:error, Error.new!(error)}
end
