defmodule Intellex.MockController do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  post "/v1/chat/completions" do
    case conn.params do
      %{
        "max_tokens" => 2048,
        "model" => "gpt-3.5-turbo",
        "prompt" => [%{"text" => "Hello", "role" => "user"}],
        "temperature" => 0.7
      } ->
        success(conn, %{
          "choices" => [
            %{
              "finish_reason" => "stop",
              "index" => 0,
              "message" => %{
                "content" =>
                  "The 2020 World Series was played at Globe Life Field in Arlington, Texas due to the COVID-19 pandemic.",
                "role" => "assistant"
              }
            }
          ],
          "created" => 1_677_773_799,
          "id" => "chatcmpl-6pftfA4NO9pOQIdxao6Z4McDlx90l",
          "model" => "gpt-3.5-turbo-0301",
          "object" => "chat.completion",
          "usage" => %{
            "completion_tokens" => 26,
            "prompt_tokens" => 56,
            "total_tokens" => 82
          }
        })

      %{
        "prompt" => [
          %{
            "role" => "system",
            "text" => "You are a mock AI. The available tools are: multiply"
          },
          %{"role" => "user", "text" => "What is 2 * 2?"}
        ]
      } ->
        success(conn, %{
          "choices" => [
            %{
              "finish_reason" => "stop",
              "index" => 0,
              "message" => %{
                "content" =>
                  "[STATUS: Incomplete] [TOOL: multiply] [OPTIONS: number_1: 2, number_2: 2]",
                "role" => "assistant"
              }
            }
          ],
          "created" => 1_677_773_799,
          "id" => "chatcmpl-6pftfA4NO9pOQIdxao6Z4McDlx90l",
          "model" => "gpt-3.5-turbo-0301",
          "object" => "chat.completion",
          "usage" => %{
            "completion_tokens" => 26,
            "prompt_tokens" => 56,
            "total_tokens" => 82
          }
        })

      %{
        "prompt" => [
          %{
            "role" => "system",
            "text" => "You are a mock AI. The available tools are: multiply"
          },
          %{"role" => "user", "text" => "What is 2 * 2?"},
          %{
            "role" => "assistant",
            "text" => "[STATUS: Incomplete] [TOOL: multiply] [OPTIONS: number_1: 2, number_2: 2]"
          },
          %{"role" => "user", "text" => "The result is: 4.0"}
        ]
      } ->
        success(conn, %{
          "choices" => [
            %{
              "finish_reason" => "stop",
              "index" => 0,
              "message" => %{
                "content" => "[STATUS: Complete] [RESULT: 4]",
                "role" => "assistant"
              }
            }
          ],
          "created" => 1_677_773_799,
          "id" => "chatcmpl-6pftfA4NO9pOQIdxao6Z4McDlx90l",
          "model" => "gpt-3.5-turbo-0301",
          "object" => "chat.completion",
          "usage" => %{
            "completion_tokens" => 26,
            "prompt_tokens" => 56,
            "total_tokens" => 82
          }
        })

      _ ->
        failure(conn)
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
