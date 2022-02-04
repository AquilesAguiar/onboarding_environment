defmodule CadProductsPhoenix.RedisCacheTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.Services.Cache

  setup do
    Cache.flush()

    %{
      key: "some_key",
      value: "some_value",
      invalid_key: "invalid_key"
    }
  end

  describe "Cache.set/2" do
    test "set a data in cache", %{key: key, value: value} do
      assert Cache.set(key, value) == {:ok, "OK"}
    end
  end

  describe "Cache.get/1" do
    test "get a data in cache, if key is valid", %{key: key, value: value} do
      Cache.set(key, value)
      assert Cache.get(key) == {:ok, "some_value"}
    end

    test "not get a data in cache, key is invalid", %{invalid_key: invalid_key} do
      assert Cache.get(invalid_key) == {:error, "key not found"}
    end
  end

  describe "Cache.delete/1" do
    test "delete a data in cache, if key is valid", %{key: key, value: value} do
      Cache.set(key, value)
      assert Cache.delete(key) == {:ok, 1}
      assert Cache.get(key) == {:error, "key not found"}
    end

    test "not delete a data in cache, key is invalid", %{invalid_key: invalid_key} do
      assert Cache.delete(invalid_key) == {:ok, 0}
    end
  end
end
