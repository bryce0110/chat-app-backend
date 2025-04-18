defmodule ChatAppBackend.ServersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatAppBackend.Servers` context.
  """

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ChatAppBackend.Servers.create_server()

    server
  end

  @doc """
  Generate a membership.
  """
  def membership_fixture(attrs \\ %{}) do
    {:ok, membership} =
      attrs
      |> Enum.into(%{
        user_id: "some user_id"
      })
      |> ChatAppBackend.Servers.create_membership()

    membership
  end
end
