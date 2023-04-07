defmodule Hexling.OpenAi.Client do
  @moduledoc """
  The OpenAI Client module provides a simple interface for making requests to the OpenAI API.
  """
  alias Hexling.Config
  alias Hexling.Http.{Response, Error}

  @doc """
  Makes a GET request to the OpenAI API
  """
  @spec get(String.t()) :: {:ok, Response.t()} | {:error, Error.t()}
  def get(path) do
    path
    |> build_path()
    |> HTTPoison.get(headers())
    |> handle_response()
  end

  @doc """
  Makes a PUT request to the OpenAI API
  """
  @spec put(String.t(), map()) :: {:ok, Response.t()} | {:error, Error.t()}
  def put(path, body) do
    path
    |> build_path()
    |> HTTPoison.put(Jason.encode!(body), headers())
    |> handle_response()
  end

  @doc """
  Makes a POST request to the OpenAI API
  """
  @spec post(String.t(), map()) :: {:ok, Response.t()} | {:error, Error.t()}
  def post(path, body) do
    path
    |> build_path()
    |> HTTPoison.post(Jason.encode!(body), headers())
    |> handle_response()
  end

  defp build_path(path) do
    Config.api_base_url() <> path
  end

  defp handle_response({:ok, response}), do: {:ok, Response.new!(response)}
  defp handle_response({:error, error}), do: {:error, Error.new!(error)}

  defp headers() do
    default_headers()
    |> add_api_key_headers()
    |> add_organization_key_headers()
  end

  defp default_headers(), do: [{"Content-type", "application/json"}]

  defp add_api_key_headers(headers) do
    [{"Authorization", "Bearer #{Config.api_key()}"} | headers]
  end

  defp add_organization_key_headers(headers) do
    case Config.organization_key() do
      "" -> headers
      org_key -> [{"OpenAI-Organization", org_key} | headers]
    end
  end
end
