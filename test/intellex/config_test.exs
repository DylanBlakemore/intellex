defmodule Intellex.ConfigTest do
  use ExUnit.Case

  alias Intellex.Config

  @application :intellex

  test "open ai api key" do
    Application.put_env(@application, :open_ai_secret, "test_api_key")
    assert Config.open_ai_secret() == "test_api_key"
  end

  test "organization key" do
    Application.put_env(@application, :open_ai_org_key, "test_org")
    assert Config.open_ai_org_key() == "test_org"
  end

  test "api base url" do
    Application.put_env(@application, :open_ai_base_url, "8082")
    assert Config.open_ai_base_url() == "8082"
  end
end
