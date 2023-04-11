defmodule Intellex.Http.Error do
  @moduledoc """
  A lightweight wrapper around the HTTPoison error object.
  """

  defstruct [:reason, :status_code]

  @type t :: %__MODULE__{}

  @doc """
  Returns a new error struct.
  """
  @spec new!(HTTPoison.Error.t()) :: t()
  def new!(error) do
    %__MODULE__{
      reason: error.reason
    }
  end
end
