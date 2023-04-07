defmodule Hexling.OpenAi.ClientTest do
  use ExUnit.Case

  alias Hexling.OpenAi.Client

  test "get" do
    Application.put_env(:hexling, :api_base_url, "http://localhost:8082")
    assert {:ok, %Hexling.Http.Response{} = response} = Client.get("/tests?id=1")
    assert response.status_code == 200
    assert response.body == %{"id" => 1, "name" => "Test 1"}
  end

  test "put" do
    Application.put_env(:hexling, :api_base_url, "http://localhost:8082")
    Application.put_env(:hexling, :headers, [{"Content-Type", "application/json"}])

    assert {:ok, %Hexling.Http.Response{} = response} =
             Client.put("/tests", %{"id" => "1", "name" => "Test 1"})

    assert response.status_code == 200
    assert response.body == %{"id" => 1, "name" => "Test 1"}
  end
end
