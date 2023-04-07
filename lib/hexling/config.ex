defmodule Hexling.Config do
  @moduledoc """
  The Hexling.Config module provides a simple interface for loading and accessing configuration data.
  """

  @openai_url "https://api.openai.com"

  @doc """
  Returns the OpenAI secret key
  """
  @spec api_key() :: String.t()
  def api_key(), do: Application.get_env(:hexling, :api_key)

  @doc """
  Returns the OpenAI organization key
  """
  @spec organization_key() :: String.t()
  def organization_key(), do: Application.get_env(:hexling, :organization_key)

  @doc """
  Returns the OpenAI API URL
  """
  @spec openai_url() :: String.t()
  def openai_url(), do: @openai_url
end
