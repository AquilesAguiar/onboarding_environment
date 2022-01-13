defmodule CadProductsPhoenix.RedisCacheTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock

  alias CadProductsPhoenix.Cache

  setup_all do
    %{
      client: "valid_client",
      key: "some_key",
      value: "some_value",
      invalid_key: "invalid_key"
    }
  end

  describe "set/1" do
    test "set a data in cache, if data is valid", %{key: key, value: value} do
      with_mock Redix,
        [command: fn(_client, ["SET", _key, _value]) ->
          {:ok, "value_cache"}
        end] do
          assert Cache.set(key, value) == {:ok, "value_cache"}
        end
    end
  end

  describe "get/1" do
    test "get a data in cache, if key is valid", %{key: key, value: value} do
      encoded_value = Base.encode16(:erlang.term_to_binary(value))
      with_mock Redix,
        [command: fn(_client, ["GET", _key]) -> {:ok, encoded_value}
        end] do
          assert Cache.get(key) == {:ok, "some_value"}
        end
    end
  end

end
