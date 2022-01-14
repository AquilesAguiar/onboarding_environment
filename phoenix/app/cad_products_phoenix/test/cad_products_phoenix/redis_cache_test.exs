defmodule CadProductsPhoenix.RedisCacheTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.Cache

  setup_all do
    %{
      name: :redix_test,
      key: "some_key",
      value: "some_value",
      invalid_key: "invalid_key"
    }
  end

  describe "redis cache test" do

    test "set a data in cache, if data is valid", %{name: name, key: key, value: value} do
      assert Cache.set(name, key, value) == {:ok, "OK"}
    end

    test "get a data in cache, if key is valid", %{name: name, key: key} do
      assert Cache.get(name, key) == {:ok, "some_value"}
    end

    test "get a data in cache, if key is invalid", %{name: name, invalid_key: invalid_key} do
      assert Cache.delete(name, invalid_key) == {:ok, 0}
    end
  end
end
