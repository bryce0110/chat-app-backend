defmodule ChatAppBackend.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :name, :string

    many_to_many :users, ChatAppBackend.Servers.Membership, join_through: "memberships"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
