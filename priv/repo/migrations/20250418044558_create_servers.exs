defmodule ChatAppBackend.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
