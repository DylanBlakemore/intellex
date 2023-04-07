defmodule Hexling.MockController do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get "/tests" do
    case conn.params do
      %{"id" => "1"} -> success(conn, %{id: 1, name: "Test 1"})
      _ -> failure(conn)
    end
  end

  put "/tests" do
    case conn.params do
      %{"id" => "1", "name" => "Test 1"} -> success(conn, %{id: 1, name: "Test 1"})
      _ -> failure(conn)
    end
  end

  defp success(conn, body) do
    conn
    |> Plug.Conn.send_resp(:ok, Jason.encode!(body))
  end

  defp failure(conn, body \\ %{}) do
    conn
    |> Plug.Conn.send_resp(:bad_request, Jason.encode!(body))
  end
end
