defmodule ChatAppBackendWeb.Plugs.FirebaseAuth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # Grabs the authorization header, which should be a Firebase JWT Token. Try to verify this, and grab the user_id
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- verify_token(token),
         user_id <- claims["user_id"] do
      assign(conn, :current_user, user_id)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.json(%{error: "Unauthorized"})
        |> halt()
    end
  end

  defp verify_token(token) do
    # Decode the Firebase JWT Token
    # JWT Tokens are typically in the format: header.payload.signature
    # We want the payload part which contains the claims, and as such the user_id
    # TODO: All this does is decode the token. We should verify it as well.
    case String.split(token, ".") do
      [_, payload, _] ->
        case Base.url_decode64(payload, padding: false) do
          {:ok, json} -> Jason.decode(json)
          :error -> {:error, :invalid_token}
        end

      _ ->
        {:error, :invalid_token}
    end
  end
end
