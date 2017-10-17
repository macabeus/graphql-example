defmodule Myapp.LikeTest do
  use Myapp.ModelCase

  alias Myapp.Like

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Like.changeset(%Like{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Like.changeset(%Like{}, @invalid_attrs)
    refute changeset.valid?
  end
end
