defmodule Intellex.Tool do
  @moduledoc """
  A tool is a function which allows the LLM to interact with our application
  """
  defstruct [:name, :description, :function, :options]

  @spec new!(String.t()) :: %__MODULE__{}
  def new!(name) do
    %__MODULE__{
      name: name,
      description: "No description provided",
      function: fn -> nil end,
      options: []
    }
  end

  @spec description(%__MODULE__{}, String.t()) :: %__MODULE__{}
  def description(tool, description) do
    %{tool | description: description}
  end

  @spec function(%__MODULE__{}, function()) :: %__MODULE__{}
  def function(tool, function) do
    %{tool | function: function}
  end

  @spec option(%__MODULE__{}, %Intellex.Option{}) :: %__MODULE__{}
  def option(tool, option) do
    %{tool | options: [option | tool.options]}
  end
end
