defmodule ChatAppBackendWeb.ServerJSON do
  alias ChatAppBackend.Servers.Server

  @doc """
  Renders a list of servers.
  """
  def index(%{servers: servers}) do
    %{data: for(server <- servers, do: data(server))}
  end

  @doc """
  Renders a single server.
  """
  def show(%{server: server}) do
    %{data: data(server)}
  end

  defp data(%Server{} = server) do
    %{
      id: server.id,
      name: server.name
    }
  end
end
