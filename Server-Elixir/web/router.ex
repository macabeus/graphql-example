defmodule Myapp.Router do
  use Myapp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Myapp.Web.Context
  end

  scope "/", Myapp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: Myapp.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Myapp.Schema

  # Other scopes may use custom stacks.
  # scope "/api", Myapp do
  #   pipe_through :api
  # end
end
