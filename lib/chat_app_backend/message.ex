defmodule ChatAppBackend.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :name, :string
    field :body, :string
    field :uuid, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(messages, attrs) do
    messages
    |> cast(attrs, [:name, :body, :uuid, :inserted_at, :updated_at])
    |> validate_required([:name, :body, :uuid, :inserted_at, :updated_at])
  end

  def recent_messages(limit \\ 10) do
    ChatAppBackend.Repo.all(ChatAppBackend.Message, limit: limit)
  end
end
