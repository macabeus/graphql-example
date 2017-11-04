defmodule Myapp.Post do
  use Myapp.Web, :model
  alias Myapp.Repo

  schema "posts" do
    field :title, :string
    field :body, :string
    field :count_likes, :integer
    field :liked, :boolean, virtual: true
    belongs_to :user, Myapp.User, foreign_key: :user_id
    has_many :likes, Myapp.Like, on_delete: :delete_all

    timestamps()
  end

  def liked(post, user_id) do
    Enum.find(post.likes, &(&1.user_id == user_id)) != nil
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
  end

  def count_likes_inc(id) do
    post = Repo.get!(Myapp.Post, id)
    cast(post, %{count_likes: post.count_likes + 1}, [:count_likes])
  end

  def count_likes_dec(id) do
    post = Repo.get!(Myapp.Post, id)
    cast(post, %{count_likes: post.count_likes - 1}, [:count_likes])
  end
end
