defmodule CadProductsPhoenix.RedisCacheTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.Cache

  setup do
    Cache.flush()
    %{
      key: "some_key",
      value: "some_value",
      invalid_key: "invalid_key"
    }
  end

  describe "redis cache test" do
    test "set a data in cache, if data is valid", %{key: key, value: value} do
      assert Cache.set(key, value) == {:ok, "OK"}
    end

    test "get a data in cache, if key is valid", %{key: key} do
      assert Cache.get(key) == {:ok, "some_value"}
    end

    test "get a data in cache, if key is invalid", %{invalid_key: invalid_key} do
      assert Cache.delete(invalid_key) == {:ok, 0}
    end
  end
end
