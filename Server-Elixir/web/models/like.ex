defmodule Myapp.Like do
  use Myapp.Web, :model

  schema "likes" do
    belongs_to :post, Myapp.Post, foreign_key: :post_id
    belongs_to :user, Myapp.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:post_id, :user_id])
    |> unique_constraint(:unique_post_user, name: :likes_post_id_user_id_index)
    |> validate_required([])
  end
end
