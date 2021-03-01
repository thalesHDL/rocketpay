defmodule AppWeb.AccountsController do
  use AppWeb, :controller
  alias App.Account
  alias App.Accoounts.Transactions.Response, as: TransactionResponse

  action_fallback AppWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- App.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- App.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction}  <- App.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
