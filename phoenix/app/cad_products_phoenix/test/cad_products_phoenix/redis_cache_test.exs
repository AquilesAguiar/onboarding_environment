defmodule CadProductsPhoenix.RedisCacheTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  setup_all do
    %{
      key: "some_key",
      value: "some_value",
      invalid_key: "invalid_key"
    }
  end

  describe "redis cache test" do

    def bid_redis_test() do
      {:ok, conn} = Redix.start_link("redis://localhost:6379/3", name: :redix_test)
      conn
    end

    test "set a data in cache, if data is valid", %{key: key, value: value} do
      conn = bid_redis_test()
      assert Redix.command(conn, ["SET", key, value]) == {:ok, "OK"}
    end

    test "get a data in cache, if key is valid", %{key: key} do
      conn = bid_redis_test()
      assert Redix.command(conn, ["GET", key]) == {:ok, "some_value"}
    end

    test "get a data in cache, if key is invalid", %{invalid_key: invalid_key} do
      conn = bid_redis_test()
      assert Redix.command(conn, ["GET", invalid_key]) == {:ok, nil}
    end
  end
end
