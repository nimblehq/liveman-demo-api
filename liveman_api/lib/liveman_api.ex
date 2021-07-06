defmodule LivemanApi do
  @moduledoc """
  API Wrapper for Liveman
  """

  @timeout 30_000

  def get(client, url, query \\ %{}),
    do: handle_response(Tesla.get(client, url, query: Map.to_list(query)))

  def post(client, url, body \\ %{}),
    do: handle_response(Tesla.post(client, url, body))

  def client(base_url, opts \\ %{}) do
    headers = opts[:headers] || []

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Content-Type", "application/json"} | headers]},
      {Tesla.Middleware.Timeout, [timeout: @timeout]}
    ]

    adapter = {Tesla.Adapter.Hackney, [recv_timeout: @timeout]}

    Tesla.client(middleware, adapter)
  end

  defp handle_response({:ok, %{status: status, body: body}}) when status in 200..299,
    do: {:ok, body}

  defp handle_response({:ok, %{status: status, body: body}}),
    do: {:error, %{status: status, body: body}}

  defp handle_response({:error, reason}), do: {:error, reason}
end
