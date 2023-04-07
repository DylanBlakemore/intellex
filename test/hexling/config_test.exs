defmodule Hexling.ConfigTest do
  use ExUnit.Case

  alias Hexling.Config

  @application :hexling

  test "api key" do
    Application.put_env(@application, :api_key, "test_api_key")
    assert Config.api_key() == "test_api_key"
  end

  test "organization key" do
    Application.put_env(@application, :organization_key, "test_org")
    assert Config.organization_key() == "test_org"
  end

  test "openai url" do
    assert Config.openai_url() == "https://api.openai.com"
  end
end
