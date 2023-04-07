defmodule Hexling.Http.Response do
  @moduledoc """
  A lightweight wrapper around the HTTPoison response object.
  """

  defstruct [:body, :headers, :status_code]

  @type t :: %__MODULE__{}

  @doc """
  Returns a new response struct.
  """
  @spec new!(HTTPoison.Response.t()) :: t()
  def new!(response) do
    %__MODULE__{
      body: Jason.decode!(response.body),
      headers: response.headers,
      status_code: response.status_code
    }
  end
end
