defmodule AppWeb.UsersViewTest do
  use AppWeb.ConnCase, async: true
  import Phoenix.View

  alias App.{User, Account}
  alias AppWeb.UsersView

  test "rendes create.json" do
    params = %{
      name: "Thales",
      password: "123456",
      nickname: "tata",
      email: "thales@ban.com",
      age: 24
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = App.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Thales",
        nickname: "tata"
      }
    }

    assert response == expected_response
  end
end
