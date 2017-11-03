defmodule Myapp.Like do
  use Myapp.Web, :model
  alias Ecto.Multi

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
end
