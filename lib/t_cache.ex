defmodule TCache do
  require Logger

  @moduledoc """
  Documentation for `TCache`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TCache.hello()
      :world

  """
  def process(socket, {host, port, data}) do
    Logger.info "#{__MODULE__}.TCache: #{:inet.ntoa(host)}:#{port}: #{inspect DNSpacket.parse(data)}"
    :ok = :gen_udp.send(socket, host, port, data)
  end
end
