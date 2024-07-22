defmodule BlogApiWeb.PostController do
  use BlogApiWeb, :controller

  alias BlogApi.Posts
  alias BlogApi.Posts.Post

  action_fallback BlogApiWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  def create(conn, post_params) do
    with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts/#{post}")
      |> render(:show, post: post)
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    if Ecto.UUID.cast(id) == :error do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Invalid ID format. Expected a valid UUID."})
    else
      case Posts.get_post(id) do
        nil ->
          {:error, :not_found}

        post ->
          render(conn, :show, post: post)
      end
    end
  end

  def update(conn, %{"id" => id} = post_params) do
    if Ecto.UUID.cast(id) == :error do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Invalid ID format. Expected a valid UUID."})
    else
      case Posts.create_or_update_post(id, post_params) do
        {:created, %Post{} = post} ->
          conn
          |> put_status(:created)
          |> render(:show, post: post)

        {:updated, %Post{} = post} ->
          conn
          |> put_status(:ok)
          |> render(:show, post: post)

        {:error, %Ecto.Changeset{} = changeset} ->
          {:error, %Ecto.Changeset{} = changeset}
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    if Ecto.UUID.cast(id) == :error do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Invalid ID format. Expected a valid UUID."})
    else
      case Posts.get_post(id) do
        nil ->
          {:error, :not_found}

        post ->
          with {:ok, %Post{}} <- Posts.delete_post(post) do
            send_resp(conn, :no_content, "")
          end
      end
    end
  end
end
