defmodule ChatAppBackendWeb.RoomChannel do
  use ChatAppBackendWeb, :channel

  @impl true
  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  defp format_message(message) do
    %{
      name: message.name,
      body: message.body,
      uuid: message.uuid,
      inserted_at: message.inserted_at,
    }
  end

  @impl true
  def handle_info(:after_join, socket) do
    ChatAppBackend.Message.recent_messages()
      |> Enum.each(fn message ->
        push(socket, "new_msg", format_message(message)) end)
    {:noreply, socket}
  end

  defp save_message(message) do
    ChatAppBackend.Message.changeset(%ChatAppBackend.Message{}, message) |> ChatAppBackend.Repo.insert()
  end

  def handle_in("new_msg", payload, socket) do
    uuid = Ecto.UUID.generate()
    payload = Map.put(payload, "uuid", uuid)
    payload = Map.put(payload, "inserted_at", DateTime.utc_now())
    payload = Map.put(payload, "updated_at", DateTime.utc_now())
    spawn(fn -> save_message(payload) end)

    broadcast!(socket, "new_msg", payload)
    {:reply, :ok, socket} # TODO: Error Handling
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
