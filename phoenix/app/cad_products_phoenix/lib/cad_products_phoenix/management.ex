defmodule CadProductsPhoenix.Management do
  @moduledoc """
  The Management context.
  """

  import Ecto.Query, warn: false

  alias CadProductsPhoenix.Management.Register
  alias CadProductsPhoenix.Repo

  @doc """
  Returns the list of register.

  ## Examples

      iex> list_register()
      [%Register{}, ...]

  """
  def list_register do
    Repo.all(Register)
  end

  @doc """
  Gets a single register.

  Raises `Ecto.NoResultsError` if the Register does not exist.

  ## Examples

      iex> get_register!(123)
      %Register{}

      iex> get_register!(456)
      ** (Ecto.NoResultsError)

  """
  def get_register(id) do
    Repo.one!(from p in Register, where: p.id == ^id)
  end

  @doc """
  Creates a register.

  ## Examples

      iex> create_register(%{field: value})
      {:ok, %Register{}}

      iex> create_register(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_register(attrs \\ %{}) do
    %Register{}
    |> Register.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a register.

  ## Examples

      iex> update_register(register, %{field: new_value})
      {:ok, %Register{}}

      iex> update_register(register, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_register(%Register{} = register, attrs) do
    register
    |> Register.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a register.

  ## Examples

      iex> delete_register(register)
      {:ok, %Register{}}

      iex> delete_register(register)
      {:error, %Ecto.Changeset{}}

  """
  def delete_register(%Register{} = register) do
    Repo.delete!(register)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking register changes.

  ## Examples

      iex> change_register(register)
      %Ecto.Changeset{data: %Register{}}

  """
  def change_register(%Register{} = register, attrs \\ %{}) do
    Register.changeset(register, attrs)
  end
end
