defmodule Intellex.Wrappers.Database do
  @callback query(String.t()) :: list()
end
