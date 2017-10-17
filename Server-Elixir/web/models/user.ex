defmodule Myapp.User do
  use Myapp.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :posts, Myapp.Post
    has_many :likes, Myapp.Like

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password])
    |> validate_required([:name, :username])
    |> put_pass_hash()
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password])
    |> validate_required([:username, :password])
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
