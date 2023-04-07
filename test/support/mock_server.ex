defmodule Hexling.MockServer do
  @moduledoc """
  A mock server used for testing.
  """
  use GenServer
  alias Hexling.MockController

  @spec init(any()) :: {:ok, any()}
  def init(args) do
    {:ok, args}
  end

  @spec start(any()) :: {:ok, pid} | {:error, :eaddrinuse} | {:error, term}
  def start(_opts) do
    Plug.Cowboy.http(MockController, [], port: 8082)
  end

  def start() do
    start([])
  end
end
