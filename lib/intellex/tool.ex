defmodule Intellex.Tool do
  @moduledoc """
  A tool is a function which allows the LLM to interact with our application
  """
  defstruct [:name, :description, :function, :options]

  @type t :: %__MODULE__{}

  defimpl String.Chars do
    @spec to_string(Intellex.Tool.t()) :: String.t()
    def to_string(tool) do
      options_string =
        tool.options
        |> Enum.map(&Kernel.to_string(&1))
        |> Enum.join("\n\t")

      base_string = "#{tool.name}: #{tool.description}."

      case options_string do
        "" -> base_string
        _ -> "#{base_string} Available options:\n\t#{options_string}"
      end
    end
  end

  @doc """
  Creates a new tool
  """
  @spec new!(String.t()) :: %__MODULE__{}
  def new!(name) do
    %__MODULE__{
      name: name,
      description: "No description provided",
      function: fn -> nil end,
      options: []
    }
  end

  @doc """
  Sets the tool's description
  """
  @spec description(%__MODULE__{}, String.t()) :: %__MODULE__{}
  def description(tool, description) do
    %{tool | description: description}
  end

  @doc """
  Sets the tool's function
  """
  @spec function(%__MODULE__{}, function()) :: %__MODULE__{}
  def function(tool, function) do
    %{tool | function: function}
  end

  @doc """
  Adds an option to the tool
  """
  @spec option(%__MODULE__{}, %Intellex.Option{} | keyword()) :: %__MODULE__{}
  def option(tool, %Intellex.Option{} = option) do
    %{tool | options: [option | tool.options]}
  end

  def option(tool, opts) do
    option(tool, Intellex.Option.new!(opts))
  end

  @doc """
  Validates the action against the tool's options
  """
  @spec validate(__MODULE__.t(), Action.t()) ::
          {:ok, __MODULE__.t()} | {:error, String.t()}
  def validate(tool, action) do
    case Enum.all?(action.options, &validate_option(tool, &1)) do
      true -> {:ok, tool}
      false -> {:error, "Invalid options for tool :#{tool.name}"}
    end
  end

  defp validate_option(tool, {name, _value}) do
    Enum.any?(tool.options, fn option ->
      option.name == name
    end)
  end

  @doc """
  Runs the tool's function with the action's options
  """
  @spec run(__MODULE__.t(), Action.t()) :: {:ok, String.t()} | {:error, String.t()}
  def run(tool, action) do
    options = Enum.into(action.options, %{})

    try do
      tool.function.(options)
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end
end
