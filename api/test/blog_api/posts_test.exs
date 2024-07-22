defmodule BlogApi.PostsTest do
  use BlogApi.DataCase

  alias BlogApi.Posts

  describe "posts" do
    alias BlogApi.Posts.Post

    import BlogApi.PostsFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "get_post!/1 throws an error when post not found" do
      non_existent_id = "a9aecc69-bf3a-4831-974a-71be34448984"

      assert_raise Ecto.NoResultsError, fn ->
        Posts.get_post!(non_existent_id)
      end
    end

    test "get_post/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post(post.id) == post
    end

    test "get_post/1 returns nil when post not found" do
      non_existent_id = "a9aecc69-bf3a-4831-974a-71be34448984"

      assert Posts.get_post(non_existent_id) == nil
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{title: "valid title", body: "valid body"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.title == "valid title"
      assert post.body == "valid body"
    end

    test "create_post/1 with empty data returns errors" do
      invalid_attrs = %{title: "", body: ""}
      assert {:error, changeset} = Posts.create_post(invalid_attrs)

      errors =
        Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)

      assert errors[:title] == ["can't be blank"]
      assert errors[:body] == ["can't be blank"]
    end

    test "create_post/1 with invalid length data returns errors" do
      invalid_attrs = %{title: "1", body: "1"}
      assert {:error, changeset} = Posts.create_post(invalid_attrs)

      errors =
        Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)

      assert errors[:title] == ["should be at least 3 character(s)"]
      assert errors[:body] == ["should be at least 10 character(s)"]
    end

    test "create_post/1 with null data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.body == "some updated body"
    end

    test "update_post/2 with null data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "update_post/2 with empty data returns errors" do
      post = post_fixture()
      invalid_attrs = %{title: "", body: ""}
      assert {:error, changeset} = Posts.update_post(post, invalid_attrs)

      errors =
        Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)

      assert errors[:title] == ["can't be blank"]
      assert errors[:body] == ["can't be blank"]
    end

    test "update_post/2 with invalid length data returns errors" do
      post = post_fixture()
      invalid_attrs = %{title: "1", body: "1"}
      assert {:error, changeset} = Posts.update_post(post, invalid_attrs)

      errors =
        Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)

      assert errors[:title] == ["should be at least 3 character(s)"]
      assert errors[:body] == ["should be at least 10 character(s)"]
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end

    test "create_or_update_post/2 creates a new post when the id does not exist" do
      non_existent_id = "00000000-0000-0000-0000-000000000000"
      valid_attrs = %{title: "valid title", body: "valid body"}

      assert {:created, new_post} = Posts.create_or_update_post(non_existent_id, valid_attrs)
      assert new_post.title == valid_attrs.title
      assert new_post.body == valid_attrs.body
    end

    test "create_or_update_post/2 with invalid attributes returns errors" do
      non_existent_id = "00000000-0000-0000-0000-000000000000"
      invalid_attrs = %{title: "1", body: "1"}

      assert {:error, changeset} = Posts.create_or_update_post(non_existent_id, invalid_attrs)

      assert changeset.errors[:title] ==
               {"should be at least %{count} character(s)",
                [count: 3, validation: :length, kind: :min, type: :string]}

      assert changeset.errors[:body] ==
               {"should be at least %{count} character(s)",
                [count: 10, validation: :length, kind: :min, type: :string]}
    end

    test "create_or_update_post/2 updates the existing post when id exists" do
      post = post_fixture()
      updated_attrs = %{title: "Title Update", body: "Another updated body with valid length."}

      assert {:updated, updated_post} = Posts.create_or_update_post(post.id, updated_attrs)
      assert updated_post.title == updated_attrs.title
      assert updated_post.body == updated_attrs.body
    end
  end
end
