defmodule ChatAppBackend.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :name, :string
    field :body, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(messages, attrs) do
    messages
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end

  def recent_messages(limit \\ 10) do
    ChatAppBackend.Repo.all(ChatAppBackend.Message, limit: limit)
  end
end
