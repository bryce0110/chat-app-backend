defmodule ChatAppBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChatAppBackendWeb.Telemetry,
      ChatAppBackend.Repo,
      {DNSCluster, query: Application.get_env(:chat_app_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChatAppBackend.PubSub},
      # Start a worker by calling: ChatAppBackend.Worker.start_link(arg)
      # {ChatAppBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      ChatAppBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatAppBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatAppBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
