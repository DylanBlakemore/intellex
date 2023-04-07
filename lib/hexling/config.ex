defmodule Hexling.Config do
  @moduledoc """
  The Hexling.Config module provides a simple interface for loading and accessing configuration data.
  """

  @doc """
  Returns the API secret key
  """
  @spec api_key() :: String.t()
  def api_key(), do: Application.get_env(:hexling, :api_key) || ""

  @doc """
  Returns the API organization key
  """
  @spec organization_key() :: String.t()
  def organization_key(), do: Application.get_env(:hexling, :organization_key) || ""

  @doc """
  Returns the headers to use when calling the API
  """
  @spec headers() :: keyword()
  def headers(), do: Application.get_env(:hexling, :headers) || []

  @doc """
  Returns the API base URL
  """
  @spec api_base_url() :: String.t()
  def api_base_url(), do: Application.get_env(:hexling, :api_base_url) || "https://api.openai.com"
end
