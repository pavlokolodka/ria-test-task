defmodule BlogApi.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias BlogApi.Repo

  alias BlogApi.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def get_post(id) do
    Repo.get(Post, id)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def update_post_with_all_attributes(%Post{} = post, attrs) do
    validated_attributes = Post.changeset(%Post{}, attrs)

    if validated_attributes.valid? do
      post
      |> Post.changeset(attrs)
      |> Repo.update()
    else
      {:error, validated_attributes}
    end
  end

  def create_or_update_post(id, attrs) do
    case Repo.get(Post, id) do
      nil ->
        case %Post{}
             |> Post.changeset(attrs)
             |> Repo.insert() do
          {:ok, post} -> {:created, post}
          {:error, changeset} -> {:error, changeset}
        end

      %Post{} = post ->
        case update_post_with_all_attributes(post, attrs) do
          {:ok, post} -> {:updated, post}
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
