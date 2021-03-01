defmodule AppWeb.UsersController do
  use AppWeb, :controller
  alias App.User

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- App.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
