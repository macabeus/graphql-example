defmodule Myapp.Schema do
  use Absinthe.Schema
  import_types Myapp.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &Myapp.PostResolver.all/2
    end

    field :users, list_of(:user) do
      resolve &Myapp.UserResolver.all/2
    end

    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &Myapp.UserResolver.find/2
    end
  end

  input_object :update_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:integer)
  end

  input_object :update_user_params do
    field :name, :string
    field :username, :string
    field :password, :string
  end

  mutation do
    field :create_user, type: :user do
      arg :username, non_null(:string)
      arg :password, non_null(:string)
      arg :name, :string

      resolve &Myapp.UserResolver.create/2
    end

    field :create_post, type: :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :user_id, non_null(:integer)

      resolve &Myapp.PostResolver.create/2
    end

    field :update_post, type: :post do
      arg :id, non_null(:integer)
      arg :post, :update_post_params

      resolve &Myapp.PostResolver.update/2
    end

    field :update_user, type: :user do
      arg :id, non_null(:integer)
      arg :user, :update_user_params

      resolve &Myapp.UserResolver.update/2
    end

    field :login, type: :session do
      arg :username, non_null(:string)
      arg :password, non_null(:string)

      resolve &Myapp.UserResolver.login/2
    end

    field :delete_post, type: :post do
      arg :id, non_null(:integer)

      resolve &Myapp.PostResolver.delete/2
    end

    field :like_post, type: :post do
      arg :user_id, non_null(:integer)
      arg :post_id, non_null(:integer)

      resolve &Myapp.PostResolver.add_like/2
    end
  end
end
