defmodule Hexling.Http.Client do
  @moduledoc """
  A generic HTTP client
  """

  @doc """
  Makes a GET request to the given URL
  """
  @spec get(String.t(), keyword()) ::
          {:ok, Hexling.Http.Response.t()} | {:error, Hexling.Http.Error.t()}
  def get(url, headers) do
    url
    |> HTTPoison.get(headers)
    |> handle_response()
  end

  @doc """
  Makes a PUT request to the given URL
  """
  @spec put(String.t(), map(), keyword()) ::
          {:ok, Hexling.Http.Response.t()} | {:error, Hexling.Http.Error.t()}
  def put(url, body, headers) do
    url
    |> HTTPoison.put(Jason.encode!(body), [{"Content-type", "application/json"} | headers])
    |> handle_response()
  end

  @doc """
  Makes a POST request to the given URL
  """
  @spec post(String.t(), map(), keyword()) ::
          {:ok, Hexling.Http.Response.t()} | {:error, Hexling.Http.Error.t()}
  def post(url, body, headers) do
    url
    |> HTTPoison.post(Jason.encode!(body), [{"Content-type", "application/json"} | headers])
    |> handle_response()
  end

  defp handle_response({:ok, response}), do: {:ok, Hexling.Http.Response.new!(response)}
  defp handle_response({:error, error}), do: {:error, Hexling.Http.Error.new!(error)}
end
