defmodule BlogApiWeb.Router do
  use BlogApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BlogApiWeb do
    pipe_through :api
    get "/", PostsController, :action
    resources "/posts", PostController
  end
end
