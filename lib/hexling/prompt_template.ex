defmodule Hexling.PromptTemplate do
  @moduledoc """
  A prompt template is a string that contains placeholders for user-defined values.

  The placeholders are defined using the following syntax: `{{variable_name}}`.
  """

  defstruct [:template, :variables]

  @type t :: %__MODULE__{}
  @variable_regex ~r/{{(\w+)}}/

  @doc """
  Creates a new template from a string. The variables are extracted from
  the string using the syntax rules
  """
  @spec new!(String.t()) :: t
  def new!(template) do
    variables = extract_variables(template)
    %__MODULE__{template: template, variables: variables}
  end

  @doc """
  Generates a prompt from a template and a map of variables. If a variable
  is missing, an error is returned.
  """
  @spec generate(t, map) :: {:ok, String.t()} | {:error, String.t()}
  def generate(%__MODULE__{} = template, variables) do
    case check_variables(template.variables, variables) do
      [] ->
        {:ok, generate_prompt(template, variables)}

      missing_variables ->
        {:error, "Missing variable: #{Enum.join(missing_variables, ", ")}"}
    end
  end

  defp check_variables(variable_names, variables) do
    variable_names -- Map.keys(variables)
  end

  defp generate_prompt(%__MODULE__{template: template}, variables) do
    Enum.reduce(variables, template, fn {variable, value}, acc ->
      Regex.replace(~r/{{#{variable}}}/, acc, to_string(value))
    end)
  end

  defp extract_variables(template) do
    @variable_regex
    |> Regex.scan(template, capture: :all_but_first)
    |> Enum.map(fn [variable] -> variable end)
  end
end
