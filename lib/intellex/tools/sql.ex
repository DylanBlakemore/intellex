defmodule Intellex.Tools.Sql do
  @moduledoc """
  Tools for interacting with SQL databases
  """
  alias Intellex.Tool

  @spec list_tables(atom()) :: Intellex.Tool.t()
  def list_tables(database) do
    func = fn ->
      tables =
        database.query(
          "SELECT table_name FROM information_schema.tables WHERE table_type='table'"
        )
        |> Enum.map(& &1["name"])

      "Available tables: #{Enum.join(tables, ", ")}"
    end

    Tool.new!("list_sql_table")
    |> Tool.description("Lists all tables in the database")
    |> Tool.function(func)
  end

  @spec inspect_table(atom()) :: Intellex.Tool.t()
  def inspect_table(database) do
    func = fn options ->
      table = options["table"]

      columns =
        database.query(
          "SELECT column_name FROM information_schema.columns WHERE table_name = '#{table}'"
        )
        |> Enum.map(& &1["column_name"])

      "Table #{table} has columns: #{Enum.join(columns, ", ")}"
    end

    Tool.new!("inspect_sql_table")
    |> Tool.description("Returns all of the columns in the database")
    |> Tool.option(name: "table", description: "The table to inspect")
    |> Tool.function(func)
  end
end
