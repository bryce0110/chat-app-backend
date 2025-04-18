defmodule ChatAppBackendWeb.ServerController do
  use ChatAppBackendWeb, :controller

  alias ChatAppBackend.Servers

  action_fallback ChatAppBackendWeb.FallbackController

  # List servers the user is a member of
  def index(conn, _params) do
    user_id = conn.assigns[:current_user]
    servers = Servers.get_server(user_id)
    render(conn, :index, servers: servers)
  end

  # Create a new server
  def create(conn, %{"name" => name}) do
    case Servers.create_server(%{name: name}) do
      {:ok, server} ->
        conn
        |> put_status(:created)
        |> render(:show, server: server)

        join(conn, %{"server_id" => server.id})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ChatAppBackendWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  # Add a user to a server
  def join(conn, %{"server_id" => server_id}) do
    user_id = conn.assigns[:current_user]

    case Servers.create_membership(%{user_id: user_id, server_id: server_id}) do
      {:ok, _membership} ->
        send_resp(conn, :no_content, "")

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ChatAppBackendWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   server = Servers.get_server!(id)
  #   render(conn, :show, server: server)
  # end

  # def update(conn, %{"id" => id, "server" => server_params}) do
  #   server = Servers.get_server!(id)

  #   with {:ok, %Server{} = server} <- Servers.update_server(server, server_params) do
  #     render(conn, :show, server: server)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   server = Servers.get_server!(id)

  #   with {:ok, %Server{}} <- Servers.delete_server(server) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
