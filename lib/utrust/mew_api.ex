defmodule Utrust.MewApi do
  @moduledoc """
  Hybrid module for interacting with myetherwallet API and parsing reponse data.
  """
  @type t :: __MODULE__

  @derive Jason.Encoder
  defstruct [:block_hash, :txh_block_number, :from, :to, :value, :txh_hash, :status]

  use Tesla

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.BaseUrl, "https://api.myetherwallet.com"

  @rounding_precision 6
  @shifting_precision 1.0e-18

  @doc """
  Returns parsed API response from [MEW](https://www.myetherwallet.com/) as a Map.
  """
  @spec get_transaction_by_txh_hash(String.t()) :: {:ok, map()} | {:error, String.t()}
  def get_transaction_by_txh_hash(txh_hash) do
    with data <- build_request("eth_getTransactionByHash", [txh_hash]),
         {:ok, transaction} <- post("/eth", data) |> parse_http() do
      {:ok, transaction}
    end
  end

  @doc """
  Returns the number of transaction blocks on ETH chain.
  """
  @spec get_block_number() :: integer() | {:error, String.t()}
  def get_block_number do
    with data <- build_request("eth_blockNumber", []),
         # We have to parse hex number from API
         {:ok, <<"0x">> <> block_number} <- post("/eth", data) |> parse_http(),
         {int_number, _} <- Integer.parse(block_number, 16) do
      int_number
    end
  end

  @doc """
  Format data into module struct. Combines reponse from two APIs, `get_transaction_by_txh_hash` and `get_block_number` as it take 2 params.
  """
  @spec format_data(map(), integer()) :: __MODULE__.t()
  def format_data(
        %{
          "blockHash" => block_hash,
          "blockNumber" => txh_block_number,
          "from" => from,
          "to" => to,
          "value" => value,
          "hash" => txh_hash
        },
        block_number
      ) do
    txh_block_number = txh_block_number |> parse_hex()
    # * If it has been at least 2 block since transaction then it's complete :)
    status = if block_number - txh_block_number > 2, do: "complete", else: "pending"

    %__MODULE__{
      block_hash: block_hash,
      from: from,
      to: to,
      txh_block_number: txh_block_number,
      value: value |> parse_thx_value(),
      txh_hash: txh_hash,
      status: status
    }
  end

  # * Private helpers

  defp parse_hex(<<"0x">> <> hex_part) do
    {number, _} = Integer.parse(hex_part, 16)
    number
  end

  defp parse_thx_value(value) do
    num = value |> parse_hex()
    Float.round(num * @shifting_precision, @rounding_precision)
  end

  defp parse_http({:ok, %{body: %{"result" => result}}}), do: {:ok, result}
  defp parse_http({:ok, %{body: %{"error" => %{"message" => error}}}}), do: {:error, error}
  defp parse_http(_), do: {:error, "Something went wrong, try again later!"}

  defp build_request(method, params) do
    %{
      jsonrpc: "2.0",
      method: method,
      params: params,
      id: 1
    }
  end
end
