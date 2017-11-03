defmodule Myapp.Post do
  use Myapp.Web, :model
  alias Myapp.Repo

  schema "posts" do
    field :title, :string
    field :body, :string
    field :count_likes, :integer
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

  def count_likes_inc(id) do
    post = Repo.get!(Myapp.Post, id)
    cast(post, %{count_likes: post.count_likes + 1}, [:count_likes])
  end
end
