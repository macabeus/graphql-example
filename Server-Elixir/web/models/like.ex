defmodule Myapp.Like do
  use Myapp.Web, :model
  alias Ecto.Multi
  alias Myapp.Repo
  alias Myapp.Like

  schema "likes" do
    belongs_to :post, Myapp.Post, foreign_key: :post_id
    belongs_to :user, Myapp.User, foreign_key: :user_id

    timestamps()
  end

  def add_like(params) do
    Multi.new
    |> Multi.insert(:likes, new_changeset(params))
    |> Multi.update(:users, Myapp.Post.count_likes_inc(params.post_id))
  end

  defp new_changeset(params) do
    %Myapp.Like{}
    |> cast(params, [:post_id, :user_id])
    |> unique_constraint(:unique_post_user, name: :likes_post_id_user_id_index)
    |> validate_required([])
  end

  def delete_like(post_id, user_id) do
    Multi.new
    |> Multi.delete(:likes, get_like(post_id, user_id))
    |> Multi.update(:users, Myapp.Post.count_likes_dec(post_id))
  end

  defp get_like(post_id, user_id) do
    Like
    |> where(post_id: ^post_id, user_id: ^user_id)
    |> Repo.one
  end
end
