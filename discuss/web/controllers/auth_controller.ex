defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)
  alias Discuss.UserModel, as: User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{
      nickname: Map.fetch!(auth.extra.user, "login"),
      token: auth.credentials.token,
      email: auth.info.email,
      provider: "github"
    }

    changeset =
      User.changeset(%{}, user_params)
      |> put_flash(:info, "Very cool!")
      |> redirect(to: topic_path(conn, :index))
  end
end
