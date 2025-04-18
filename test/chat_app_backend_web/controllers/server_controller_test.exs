defmodule ChatAppBackendWeb.ServerControllerTest do
  use ChatAppBackendWeb.ConnCase

  import ChatAppBackend.ServersFixtures
  alias ChatAppBackend.Servers.Server

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all servers", %{conn: conn} do
      conn = get(conn, ~p"/api/servers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create server" do
    test "renders server when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/servers", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      # conn = get(conn, ~p"/api/servers/#{id}")

      # assert %{
      #          "id" => ^id,
      #          "name" => "some name"
      #        } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/servers", server: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update server" do
    setup [:create_server]

    test "renders server when data is valid", %{conn: conn, server: %Server{id: id} = server} do
      conn = put(conn, ~p"/api/servers/#{server}", server: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/servers/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, server: server} do
      conn = put(conn, ~p"/api/servers/#{server}", server: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete server" do
    setup [:create_server]

    test "deletes chosen server", %{conn: conn, server: server} do
      conn = delete(conn, ~p"/api/servers/#{server}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/servers/#{server}")
      end
    end
  end

  defp create_server(_) do
    server = server_fixture()

    %{server: server}
  end
end
