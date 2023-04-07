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

  test "api base url" do
    Application.put_env(@application, :api_base_url, "8082")
    assert Config.api_base_url() == "8082"
  end
end
