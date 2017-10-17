defmodule Myapp.Post do
  use Myapp.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string
    belongs_to :user, Myapp.User, foreign_key: :user_id
    has_many :likes, Myapp.Like, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
  end
end
