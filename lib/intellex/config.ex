defmodule Intellex.Config do
  @moduledoc """
  The Intellex.Config module provides a simple interface for loading and accessing configuration data.
  """

  @doc """
  Returns the API secret key
  """
  @spec open_ai_secret() :: String.t()
  def open_ai_secret(), do: Application.get_env(:intellex, :open_ai_secret) || ""

  @doc """
  Returns the API organization key
  """
  @spec open_ai_org_key() :: String.t()
  def open_ai_org_key(), do: Application.get_env(:intellex, :open_ai_org_key) || ""

  @doc """
  Returns the API base URL
  """
  @spec open_ai_base_url() :: String.t()
  def open_ai_base_url(),
    do: Application.get_env(:intellex, :open_ai_base_url) || "https://api.openai.com"
end
