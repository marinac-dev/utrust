defmodule UtrustWeb.Api.BlockchainController do
  use UtrustWeb, :controller

  alias Utrust.MewApi

  def check_transaction(conn, %{"thx_hash" => thx_hash}) do
    with {:ok, thx_data} <- MewApi.get_transaction_by_txh_hash(thx_hash),
         block_number <- MewApi.get_block_number(),
         transaction_data <- MewApi.format_data(thx_data, block_number) do
      conn |> json(transaction_data)
    else
      {:error, error} ->
        conn |> json(error)
    end
  end
end
