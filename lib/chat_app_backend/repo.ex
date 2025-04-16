defmodule ChatAppBackend.Repo do
  use Ecto.Repo,
    otp_app: :chat_app_backend,
    adapter: Ecto.Adapters.Postgres
end
