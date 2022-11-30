defmodule UtrustWeb.Live.Blockchain do
  use UtrustWeb, :live_view

  alias Utrust.MewApi
  alias UtrustWeb.Live.Components.Report

  @impl true
  def mount(_args, _session, socket) do
    {:ok, socket |> assign(:data, nil)}
  end

  @impl true
  def handle_event("check-thx", %{"form" => %{"txn_hash" => txn_hash}}, socket) do
    with {:ok, json_data} <- MewApi.get_transaction_by_txh_hash(txn_hash),
         block_number <- MewApi.get_block_number(),
         transaction_data <- MewApi.format_data(json_data, block_number) do
      {:noreply, socket |> assign(:data, transaction_data)}
    else
      {:error, reason} ->
        {:noreply,
         socket
         |> assign(:data, nil)
         |> put_flash(:error, reason)}
    end
  end
end
