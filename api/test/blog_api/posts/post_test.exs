defmodule BlogApi.PostsTest.PostTest do
  use ExUnit.Case
  alias BlogApi.Posts.Post

  @post_schema [
    {:id, :binary_id},
    {:title, :string},
    {:body, :string},
    {:inserted_at, :utc_datetime},
    {:updated_at, :utc_datetime}
  ]

  describe "post fields and types" do
    test "it should match post_schema" do
      actual_post_schema =
        for field <- Post.__schema__(:fields) do
          type = Post.__schema__(:type, field)
          {field, type}
        end

      assert MapSet.new(actual_post_schema) == MapSet.new(@post_schema)
    end
  end
end
