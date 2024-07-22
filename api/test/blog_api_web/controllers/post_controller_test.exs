defmodule BlogApiWeb.PostControllerTest do
  use BlogApiWeb.ConnCase

  import BlogApi.PostsFixtures

  alias BlogApi.Posts.Post

  @create_attrs %{
    title: "valid title",
    body: "valid body"
  }
  @update_attrs %{
    title: "some updated title",
    body: "some updated body"
  }
  @invalid_attrs %{title: nil, body: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/api/posts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "get one" do
    test "returns post when id is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", @create_attrs)
      assert %{"id" => id} = created_post = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert ^created_post = json_response(conn, 200)["data"]
    end

    test "returns 404 when post is not found", %{conn: conn} do
      non_existent_id = "00000000-0000-0000-0000-000000000000"
      conn = get(conn, ~p"/api/posts/#{non_existent_id}")

      assert json_response(conn, 404)["errors"] != %{}
    end

    test "returns 400 when id is not valid", %{conn: conn} do
      non_valid_id = "0"
      conn = get(conn, ~p"/api/posts/#{non_valid_id}")

      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", @create_attrs)

      assert %{
               "id" => id,
               "body" => body,
               "title" => title,
               "inserted_at" => inserted_at,
               "updated_at" => updated_at
             } = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "body" => ^body,
               "title" => ^title,
               "inserted_at" => ^inserted_at,
               "updated_at" => ^updated_at
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, ~p"/api/posts/#{post}", @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some updated body",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "returns 400 when id is not valid", %{conn: conn} do
      non_valid_id = "0"
      conn = put(conn, ~p"/api/posts/#{non_valid_id}")

      assert json_response(conn, 400)["errors"] != %{}
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/api/posts/#{post}", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/api/posts/#{post}")
      assert response(conn, 204)

      get_conn = get(conn, ~p"/api/posts/#{post}")

      assert response(get_conn, 404)
    end

    test "returns 404 when post is not found", %{conn: conn} do
      non_existent_id = "00000000-0000-0000-0000-000000000000"
      conn = delete(conn, ~p"/api/posts/#{non_existent_id}")

      assert json_response(conn, 404)["errors"] != %{}
    end

    test "returns 400 when id is not valid", %{conn: conn} do
      non_valid_id = "0"
      conn = get(conn, ~p"/api/posts/#{non_valid_id}")

      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
