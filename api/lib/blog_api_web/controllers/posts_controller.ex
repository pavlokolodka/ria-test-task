defmodule BlogApiWeb.PostsController do
  use BlogApiWeb, :controller

  def action(conn, _options) do
    text(conn, "Hello world!")
  end
end
