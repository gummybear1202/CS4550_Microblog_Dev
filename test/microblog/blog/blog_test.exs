defmodule Microblog.BlogTest do
  use Microblog.DataCase

  alias Microblog.Blog

  describe "messages" do
    alias Microblog.Blog.Message

    @valid_attrs %{desc: "some desc", user: "some user"}
    @update_attrs %{desc: "some updated desc", user: "some updated user"}
    @invalid_attrs %{desc: nil, user: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Blog.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Blog.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Blog.create_message(@valid_attrs)
      assert message.desc == "some desc"
      assert message.user == "some user"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Blog.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.desc == "some updated desc"
      assert message.user == "some updated user"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_message(message, @invalid_attrs)
      assert message == Blog.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Blog.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Blog.change_message(message)
    end
  end
end
