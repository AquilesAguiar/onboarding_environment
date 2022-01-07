defmodule CadProductsPhoenix.ManagementTest do
  use CadProductsPhoenix.DataCase, async: false

  alias CadProductsPhoenix.Management

  describe "register" do
    alias CadProductsPhoenix.Management.Register

    @valid_attrs %{description: "some description", name: "some name", price: 120.5, qtd: 120, sku: "some sku"}
    @update_attrs %{description: "some updated description", name: "some updated name", price: 456.7, qtd: 456, sku: "some updated sku"}
    @invalid_attrs %{description: nil, name: nil, price: nil, qtd: nil, sku: nil}

    def register_fixture(attrs \\ %{}) do
      {:ok, register} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Management.create_register()

      register
    end

    test "list_register/0 returns all register" do
      register = register_fixture()
      assert Management.list_register() == [register]
    end

    test "get_register!/1 returns the register with given id" do
      register = register_fixture()
      assert Management.get_register(register.id) == register
    end

    test "create_register/1 with valid data creates a register" do
      assert {:ok, %Register{} = register} = Management.create_register(@valid_attrs)
      assert register.description == "some description"
      assert register.name == "some name"
      assert register.price == 120.5
      assert register.qtd == 120
      assert register.sku == "some sku"
    end

    test "create_register/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_register(@invalid_attrs)
    end

    test "update_register/2 with valid data updates the register" do
      register = register_fixture()
      assert {:ok, %Register{} = register} = Management.update_register(register, @update_attrs)
      assert register.description == "some updated description"
      assert register.name == "some updated name"
      assert register.price == 456.7
      assert register.qtd == 456
      assert register.sku == "some updated sku"
    end

    test "update_register/2 with invalid data returns error changeset" do
      register = register_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_register(register, @invalid_attrs)
      assert register == Management.get_register(register.id)
    end

    test "delete_register/1 deletes the register" do
      register = register_fixture()
      {:ok, deleted_product} =Management.delete_register(register)
      assert %Register{} = deleted_product
      assert_raise Ecto.NoResultsError, fn -> Management.get_register(register.id) end
    end

    test "change_register/1 returns a register changeset" do
      register = register_fixture()
      assert %Ecto.Changeset{} = Management.change_register(register)
    end
  end
end
