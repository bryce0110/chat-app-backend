defmodule ChatAppBackend.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :body, :string
      add :uuid, :uuid, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
