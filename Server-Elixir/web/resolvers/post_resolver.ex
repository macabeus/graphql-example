defmodule Myapp.PostResolver do
  import Ecto.Query, only: [where: 2]
  import Myapp.ResolversMisc
  alias Myapp.Repo
  alias Myapp.Post
  alias Myapp.Like

  def fetch(args, info) do
    # filter by user id, if requested
    posts = case args do
      %{user_id: filter_by_user_id} ->
        Post
        |> where(user_id: ^filter_by_user_id)
        |> Repo.all
      _ ->
        Post
        |> Repo.all
    end

    # mark if the post is liked or not, if the user is logged
    posts = case info do
      %{context: %{current_user: %{id: id}}} ->
        posts
        |> Repo.preload(likes: :post)
        |> Enum.map(&(%{&1 | liked: Post.liked(&1, id)}))
      _ ->
        posts
    end

    #
    {:ok, posts}
  end

  def create(args, %{context: %{current_user: %{id: id}}}) do
    add_post_params = Map.put(args, :user_id, id)
    %Post{}
    |> Post.changeset(add_post_params)
    |> Repo.insert
  end

  def create(_args, _info) do
    {:error, "Not Authorized"}
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
