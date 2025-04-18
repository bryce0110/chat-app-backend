defmodule ChatAppBackend.Servers.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :user_id, :string

    belongs_to :server, ChatAppBackend.Servers.Server

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:user_id, :server_id])
    |> validate_required([:user_id, :server_id])
    |> unique_constraint([:user_id, :server_id])
  end
end
