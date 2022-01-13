defmodule CadProductsPhoenix.RedisCacheTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  setup_all do
    %{
      key: "some_key",
      value: "some_value",
      invalid_key: "invalid_key"
    }
  end

  def bid_redis_test() do
    {:ok, conn} = Redix.start_link("redis://localhost:6379/3", name: :redix_test)
    conn
  end

  describe "set/1" do
    test "set a data in cache, if data is valid", %{key: key, value: value} do
      conn = bid_redis_test()
      assert Redix.command(conn, ["SET", key, value]) == {:ok, "OK"}
    end
  end

  describe "get/1" do
    test "get a data in cache, if key is valid", %{key: key} do
      conn = bid_redis_test()
      assert Redix.command(conn, ["GET", key]) == {:ok, "some_value"}
    end
  end
end
