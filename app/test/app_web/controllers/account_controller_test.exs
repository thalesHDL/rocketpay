defmodule AppWeb.AccountsControllerTest do
  use AppWeb.ConnCase, async: true

  alias Ecto.UUID
  alias App.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Thales",
        password: "123456",
        nickname: "tata",
        email: "thales@ban.com",
        age: 24
      }

      {:ok, %User{account: %Account{id: account_id}}} = App.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Ballance changed successfully"
      } = response
    end

    test "when there are invalid value, returns an error", %{conn: conn, account_id: account_id} do
      invalid_value = "asdfasd"
      params = %{"value" => invalid_value}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid value!"}

      assert response == expected_response
    end

    test "when there are invalid account id, returns an error", %{conn: conn, account_id: _account_id} do
      invalid_account_id = UUID.generate()
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, invalid_account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Account not found!"}

      assert response == expected_response
    end
  end
end
