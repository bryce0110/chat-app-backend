defmodule ChatAppBackend.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :user_id, :string
      add :server_id, references(:servers, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:members, [:server_id])
  end
end
