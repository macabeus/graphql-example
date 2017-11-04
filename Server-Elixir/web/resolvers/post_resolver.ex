defmodule Myapp.PostResolver do
  import Ecto.Query, only: [where: 2]
  import Myapp.ResolversMisc
  alias Myapp.Repo
  alias Myapp.Post
  alias Myapp.Like

  def all(_args, %{context: %{current_user: %{id: id}}}) do
    posts =
      Post
      |> where(user_id: ^id)
      |> Repo.all
      |> Repo.preload(likes: :post)
      |> Enum.map(&(%{&1 | liked: Post.liked(&1, id)}))

    {:ok, posts}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create(args, _info) do
    %Post{}
    |> Post.changeset(args)
    |> Repo.insert
  end

  def update(%{id: id, post: post_params}, _info) do
    Repo.get!(Post, id)
    |> Post.changeset(post_params)
    |> Repo.update
  end

  def delete(%{id: id}, _info) do
    case Repo.get(Post, id) do
      nil -> {:error, "Post id #{id} not found"}
      post -> Repo.delete(post)
    end
  end

  def add_like(args, %{context: %{current_user: %{id: id}}}) do
    add_like_params = %{post_id: args.post_id, user_id: id}
    case Repo.transaction(Like.add_like(add_like_params)) do
      {:ok, changeset} -> {:ok, changeset.likes}
      {_, _, changeset, _} -> {:error, format_errors_messages(changeset)}
    end
  end

  def add_like(_args, _info) do
    {:error, "Not Authorized"}
  end

  def delete_like(args, %{context: %{current_user: %{id: id}}}) do
    case Repo.transaction(Like.delete_like(args.post_id, id)) do
      {:ok, changeset} -> {:ok, changeset.likes}
      {_, _, changeset, _} -> {:error, format_errors_messages(changeset)}
    end
  end

  def delete_like(_args, _info) do
    {:error, "Not Authorized"}
  end
end
