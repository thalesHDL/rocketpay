defmodule AppWeb.FallbackController do
  use AppWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(AppWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
