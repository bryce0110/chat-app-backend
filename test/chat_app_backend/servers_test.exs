defmodule ChatAppBackend.ServersTest do
  use ChatAppBackend.DataCase

  alias ChatAppBackend.Servers

  describe "servers" do
    alias ChatAppBackend.Servers.Server

    import ChatAppBackend.ServersFixtures

    @invalid_attrs %{name: nil}

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Servers.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Servers.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Server{} = server} = Servers.create_server(valid_attrs)
      assert server.name == "some name"
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Servers.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Server{} = server} = Servers.update_server(server, update_attrs)
      assert server.name == "some updated name"
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Servers.update_server(server, @invalid_attrs)
      assert server == Servers.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Servers.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Servers.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Servers.change_server(server)
    end
  end

  describe "members" do
    alias ChatAppBackend.Servers.Membership

    import ChatAppBackend.ServersFixtures

    @invalid_attrs %{user_id: nil}

    test "list_members/0 returns all members" do
      membership = membership_fixture()
      assert Servers.list_members() == [membership]
    end

    test "get_membership!/1 returns the membership with given id" do
      membership = membership_fixture()
      assert Servers.get_membership!(membership.id) == membership
    end

    test "create_membership/1 with valid data creates a membership" do
      valid_attrs = %{user_id: "some user_id"}

      assert {:ok, %Membership{} = membership} = Servers.create_membership(valid_attrs)
      assert membership.user_id == "some user_id"
    end

    test "create_membership/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Servers.create_membership(@invalid_attrs)
    end

    test "update_membership/2 with valid data updates the membership" do
      membership = membership_fixture()
      update_attrs = %{user_id: "some updated user_id"}

      assert {:ok, %Membership{} = membership} = Servers.update_membership(membership, update_attrs)
      assert membership.user_id == "some updated user_id"
    end

    test "update_membership/2 with invalid data returns error changeset" do
      membership = membership_fixture()
      assert {:error, %Ecto.Changeset{}} = Servers.update_membership(membership, @invalid_attrs)
      assert membership == Servers.get_membership!(membership.id)
    end

    test "delete_membership/1 deletes the membership" do
      membership = membership_fixture()
      assert {:ok, %Membership{}} = Servers.delete_membership(membership)
      assert_raise Ecto.NoResultsError, fn -> Servers.get_membership!(membership.id) end
    end

    test "change_membership/1 returns a membership changeset" do
      membership = membership_fixture()
      assert %Ecto.Changeset{} = Servers.change_membership(membership)
    end
  end
end
