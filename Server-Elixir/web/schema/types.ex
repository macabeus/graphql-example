defmodule Myapp.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Myapp.Repo

  object :user do
    field :id, :integer
    field :name, :string
    field :username, :string
    field :posts, list_of(:post), resolve: assoc(:posts)
    field :like, list_of(:like), resolve: assoc(:likes)
  end

  object :post do
    field :id, :integer
    field :title, :string
    field :body, :string
    field :user, :user, resolve: assoc(:user)
    field :count_likes, :integer
    field :liked, :boolean
    field :like, list_of(:like), resolve: assoc(:likes)
  end

  object :session do
    field :user, :user
    field :token, :string
  end

  object :like do
    field :post, :post, resolve: assoc(:post)
    field :user, :user, resolve: assoc(:user)
  end
end
