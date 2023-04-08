defmodule Hexling.LLMs.OpenAITest do
  use ExUnit.Case

  alias Hexling.LLMs.OpenAI

  test "get" do
    Application.put_env(:hexling, :open_ai_base_url, "http://localhost:8082")
    assert {:ok, %Hexling.Http.Response{} = response} = OpenAI.get("/tests?id=1")
    assert response.status_code == 200
    assert response.body == %{"id" => 1, "name" => "Test 1"}
  end

  test "put" do
    Application.put_env(:hexling, :open_ai_base_url, "http://localhost:8082")

    assert {:ok, %Hexling.Http.Response{} = response} =
             OpenAI.put("/tests", %{"id" => "1", "name" => "Test 1"})

    assert response.status_code == 200
    assert response.body == %{"id" => 1, "name" => "Test 1"}
  end

  test "post" do
    Application.put_env(:hexling, :open_ai_base_url, "http://localhost:8082")

    assert {:ok, %Hexling.Http.Response{} = response} =
             OpenAI.post("/tests", %{"name" => "Test 1"})

    assert response.status_code == 200
    assert response.body == %{"id" => 1, "name" => "Test 1"}
  end
end
