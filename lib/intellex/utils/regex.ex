defmodule Intellex.Utils.Regex do
  def capture(string, regex) do
    Regex.run(regex, string, capture: :all_but_first)
  end
end
